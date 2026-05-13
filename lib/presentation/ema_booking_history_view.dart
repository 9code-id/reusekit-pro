import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaBookingHistoryView extends StatefulWidget {
  const EmaBookingHistoryView({super.key});

  @override
  State<EmaBookingHistoryView> createState() => _EmaBookingHistoryViewState();
}

class _EmaBookingHistoryViewState extends State<EmaBookingHistoryView> {
  String selectedFilter = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> bookings = [
    {
      "id": "EMA-2024-001567",
      "event": {
        "title": "Flutter Conference 2024",
        "date": "2024-07-15",
        "time": "09:00",
        "location": "Grand Convention Center",
        "image": "https://picsum.photos/300/160?random=1&keyword=conference"
      },
      "tickets": 3,
      "total": 630.0,
      "status": "Confirmed",
      "booking_date": "2024-06-19",
      "attendees": ["John Doe", "Jane Smith", "Mike Johnson"]
    },
    {
      "id": "EMA-2024-001234",
      "event": {
        "title": "Tech Summit 2024",
        "date": "2024-06-25",
        "time": "08:30",
        "location": "Digital Hub Center",
        "image": "https://picsum.photos/300/160?random=2&keyword=tech"
      },
      "tickets": 1,
      "total": 180.0,
      "status": "Completed",
      "booking_date": "2024-05-15",
      "attendees": ["John Doe"]
    },
    {
      "id": "EMA-2024-000987",
      "event": {
        "title": "Mobile Dev Workshop",
        "date": "2024-06-01",
        "time": "10:00",
        "location": "Innovation Lab",
        "image": "https://picsum.photos/300/160?random=3&keyword=workshop"
      },
      "tickets": 2,
      "total": 120.0,
      "status": "Cancelled",
      "booking_date": "2024-05-20",
      "attendees": ["John Doe", "Sarah Wilson"]
    },
    {
      "id": "EMA-2024-000756",
      "event": {
        "title": "UI/UX Design Conference",
        "date": "2024-05-15",
        "time": "09:30",
        "location": "Creative Space",
        "image": "https://picsum.photos/300/160?random=4&keyword=design"
      },
      "tickets": 1,
      "total": 250.0,
      "status": "Completed",
      "booking_date": "2024-04-10",
      "attendees": ["John Doe"]
    },
    {
      "id": "EMA-2024-000523",
      "event": {
        "title": "Cloud Computing Expo",
        "date": "2024-08-20",
        "time": "08:00",
        "location": "Expo Center",
        "image": "https://picsum.photos/300/160?random=5&keyword=cloud"
      },
      "tickets": 4,
      "total": 800.0,
      "status": "Pending",
      "booking_date": "2024-06-18",
      "attendees": ["John Doe", "Jane Smith", "Mike Johnson", "Sarah Wilson"]
    }
  ];

  List<Map<String, dynamic>> get filteredBookings {
    List<Map<String, dynamic>> filtered = bookings;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((booking) => booking["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((booking) {
        final eventTitle = (booking["event"]["title"] as String).toLowerCase();
        final bookingId = (booking["id"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return eventTitle.contains(query) || bookingId.contains(query);
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking History"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndStats(),
          Expanded(
            child: _buildBookingsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search events or booking ID...",
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
          _buildQuickStats(),
          _buildFilterChips(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final totalBookings = bookings.length;
    final completedBookings = bookings.where((b) => b["status"] == "Completed").length;
    final upcomingBookings = bookings.where((b) => b["status"] == "Confirmed").length;
    final totalSpent = bookings.fold(0.0, (sum, booking) => sum + (booking["total"] as double));

    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: _buildStatCard("Total", "$totalBookings", Icons.confirmation_number, primaryColor),
        ),
        Expanded(
          child: _buildStatCard("Completed", "$completedBookings", Icons.check_circle, successColor),
        ),
        Expanded(
          child: _buildStatCard("Upcoming", "$upcomingBookings", Icons.schedule, warningColor),
        ),
        Expanded(
          child: _buildStatCard("Spent", "\$${(totalSpent).currency}", Icons.account_balance_wallet, infoColor),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 20),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ["All", "Confirmed", "Completed", "Cancelled", "Pending"];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: spSm,
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return GestureDetector(
            onTap: () {
              selectedFilter = filter;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBookingsList() {
    if (filteredBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spMd,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No bookings found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filter criteria",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredBookings.length,
      itemBuilder: (context, index) {
        final booking = filteredBookings[index];
        return _buildBookingCard(booking);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final event = booking["event"] as Map<String, dynamic>;
    final status = booking["status"] as String;
    
    Color statusColor;
    switch (status) {
      case "Confirmed":
        statusColor = successColor;
        break;
      case "Completed":
        statusColor = primaryColor;
        break;
      case "Cancelled":
        statusColor = dangerColor;
        break;
      case "Pending":
        statusColor = warningColor;
        break;
      default:
        statusColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                child: Image.network(
                  "${event["image"]}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${DateTime.parse(event["date"]).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${event["time"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${event["location"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${booking["tickets"]} ticket(s)",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${((booking["total"] as double)).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
            ),
            child: Row(
              children: [
                Text(
                  "Booking ID: ${booking["id"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo EmaBookingDetailView
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Filter Bookings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Text(
                "Select booking status to filter results",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Column(
                spacing: spSm,
                children: ["All", "Confirmed", "Completed", "Cancelled", "Pending"].map((filter) {
                  return Container(
                    width: double.infinity,
                    child: QButton(
                      label: filter,
                      size: bs.md,
                      onPressed: () {
                        selectedFilter = filter;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
