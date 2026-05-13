import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation6View extends StatefulWidget {
  @override
  State<GrlReservation6View> createState() => _GrlReservation6ViewState();
}

class _GrlReservation6ViewState extends State<GrlReservation6View> {
  int selectedTab = 0;
  String selectedFilter = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> reservations = [
    {
      "id": "RSV001",
      "type": "Hotel",
      "name": "Grand Plaza Hotel",
      "location": "New York, NY",
      "date": "2024-03-20",
      "time": "3:00 PM",
      "duration": "3 nights",
      "guests": 2,
      "status": "Confirmed",
      "price": 450.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=hotel",
      "confirmationCode": "HPL2024001"
    },
    {
      "id": "RSV002",
      "type": "Restaurant",
      "name": "Sunset Bistro",
      "location": "Los Angeles, CA",
      "date": "2024-03-18",
      "time": "7:30 PM",
      "duration": "2 hours",
      "guests": 4,
      "status": "Pending",
      "price": 180.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=restaurant",
      "confirmationCode": "SB2024002"
    },
    {
      "id": "RSV003",
      "type": "Flight",
      "name": "American Airlines",
      "location": "Chicago, IL → Miami, FL",
      "date": "2024-03-25",
      "time": "10:15 AM",
      "duration": "3h 45m",
      "guests": 1,
      "status": "Confirmed",
      "price": 320.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=airplane",
      "confirmationCode": "AA2024003"
    },
    {
      "id": "RSV004",
      "type": "Event",
      "name": "Concert Hall",
      "location": "Boston, MA",
      "date": "2024-03-12",
      "time": "8:00 PM",
      "duration": "3 hours",
      "guests": 2,
      "status": "Cancelled",
      "price": 120.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=concert",
      "confirmationCode": "CH2024004"
    },
    {
      "id": "RSV005",
      "type": "Car Rental",
      "name": "Enterprise",
      "location": "Seattle, WA",
      "date": "2024-03-22",
      "time": "9:00 AM",
      "duration": "5 days",
      "guests": 1,
      "status": "Confirmed",
      "price": 280.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=car",
      "confirmationCode": "EN2024005"
    }
  ];

  List<String> filterOptions = ["All", "Hotel", "Restaurant", "Flight", "Event", "Car Rental"];
  List<String> statusTabs = ["All", "Confirmed", "Pending", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Reservations"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildStatusTabs(),
          Expanded(
            child: _buildReservationsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search reservations...",
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
          SizedBox(height: spSm),
          QCategoryPicker(
            items: filterOptions.map((filter) => {
              "label": filter,
              "value": filter,
            }).toList(),
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              selectedFilter = value;
              setState(() {});
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

  Widget _buildReservationsList() {
    List<Map<String, dynamic>> filteredReservations = _getFilteredReservations();

    if (filteredReservations.isEmpty) {
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
              "No reservations found",
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
        children: filteredReservations.map((reservation) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            child: _buildReservationCard(reservation),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReservationCard(Map<String, dynamic> reservation) {
    Color statusColor = _getStatusColor(reservation["status"]);
    IconData typeIcon = _getTypeIcon(reservation["type"]);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Header with image and basic info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusLg),
                  bottomLeft: Radius.circular(radiusLg),
                ),
                child: Image.network(
                  "${reservation["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(typeIcon, size: 16, color: primaryColor),
                          SizedBox(width: spXs),
                          Text(
                            "${reservation["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${reservation["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${reservation["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${reservation["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Details section
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildDetailItem(
                      Icons.calendar_today,
                      "Date",
                      DateTime.parse(reservation["date"]).dMMMy,
                    ),
                    SizedBox(width: spMd),
                    _buildDetailItem(
                      Icons.access_time,
                      "Time",
                      "${reservation["time"]}",
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildDetailItem(
                      Icons.schedule,
                      "Duration",
                      "${reservation["duration"]}",
                    ),
                    SizedBox(width: spMd),
                    _buildDetailItem(
                      Icons.people,
                      "Guests",
                      "${reservation["guests"]} ${reservation["guests"] == 1 ? 'person' : 'people'}",
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildDetailItem(
                      Icons.confirmation_number,
                      "Code",
                      "${reservation["confirmationCode"]}",
                    ),
                    SizedBox(width: spMd),
                    _buildDetailItem(
                      Icons.attach_money,
                      "Price",
                      "\$${(reservation["price"] as double).toStringAsFixed(0)}",
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action buttons
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusLg),
                bottomRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    color: disabledBoldColor,
                    onPressed: () {
                      _viewReservationDetails(reservation);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                if (reservation["status"] == "Confirmed") ...[
                  Expanded(
                    child: QButton(
                      label: "Modify",
                      size: bs.sm,
                      onPressed: () {
                        _modifyReservation(reservation);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.cancel,
                    size: bs.sm,
                    color: dangerColor,
                    onPressed: () {
                      _cancelReservation(reservation);
                    },
                  ),
                ] else if (reservation["status"] == "Pending") ...[
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      color: dangerColor,
                      onPressed: () {
                        _cancelReservation(reservation);
                      },
                    ),
                  ),
                ],
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
                    fontSize: 14,
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

  List<Map<String, dynamic>> _getFilteredReservations() {
    List<Map<String, dynamic>> filtered = reservations;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((reservation) {
        return reservation["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               reservation["location"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               reservation["confirmationCode"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by type
    if (selectedFilter != "All") {
      filtered = filtered.where((reservation) => reservation["type"] == selectedFilter).toList();
    }

    // Filter by status
    if (selectedTab > 0) {
      String statusFilter = statusTabs[selectedTab];
      filtered = filtered.where((reservation) => reservation["status"] == statusFilter).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Hotel":
        return Icons.hotel;
      case "Restaurant":
        return Icons.restaurant;
      case "Flight":
        return Icons.flight;
      case "Event":
        return Icons.event;
      case "Car Rental":
        return Icons.car_rental;
      default:
        return Icons.bookmark;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Additional filtering options will be available here."),
          ],
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

  void _viewReservationDetails(Map<String, dynamic> reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${reservation["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Confirmation: ${reservation["confirmationCode"]}"),
            SizedBox(height: spSm),
            Text("Date: ${DateTime.parse(reservation["date"]).dMMMy}"),
            Text("Time: ${reservation["time"]}"),
            Text("Location: ${reservation["location"]}"),
            Text("Status: ${reservation["status"]}"),
          ],
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

  void _modifyReservation(Map<String, dynamic> reservation) {
    si("Modify reservation feature coming soon");
  }

  void _cancelReservation(Map<String, dynamic> reservation) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this reservation?");
    if (isConfirmed) {
      showLoading();
      
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        
        // Update reservation status
        reservation["status"] = "Cancelled";
        setState(() {});
        
        ss("Reservation cancelled successfully");
      });
    }
  }
}
