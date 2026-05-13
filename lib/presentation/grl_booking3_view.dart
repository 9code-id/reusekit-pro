import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking3View extends StatefulWidget {
  @override
  State<GrlBooking3View> createState() => _GrlBooking3ViewState();
}

class _GrlBooking3ViewState extends State<GrlBooking3View> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> bookings = [
    {
      "id": "BK001",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.johnson@email.com",
      "customerPhone": "+1 (555) 123-4567",
      "service": "Haircut & Styling",
      "date": "2024-01-20",
      "time": "10:00",
      "duration": 60,
      "price": 45.0,
      "status": "confirmed",
      "notes": "Prefers layered cut",
      "createdAt": "2024-01-15T09:30:00Z",
      "staffMember": "Emma Wilson"
    },
    {
      "id": "BK002", 
      "customerName": "Michael Chen",
      "customerEmail": "m.chen@email.com",
      "customerPhone": "+1 (555) 987-6543",
      "service": "Deep Tissue Massage",
      "date": "2024-01-20",
      "time": "14:30",
      "duration": 90,
      "price": 110.0,
      "status": "pending",
      "notes": "Lower back focus",
      "createdAt": "2024-01-16T14:15:00Z",
      "staffMember": "David Rodriguez"
    },
    {
      "id": "BK003",
      "customerName": "Emily Davis",
      "customerEmail": "emily.d@email.com", 
      "customerPhone": "+1 (555) 456-7890",
      "service": "Facial Treatment",
      "date": "2024-01-18",
      "time": "11:00",
      "duration": 75,
      "price": 85.0,
      "status": "completed",
      "notes": "Sensitive skin - hypoallergenic products",
      "createdAt": "2024-01-14T16:45:00Z",
      "staffMember": "Lisa Park"
    },
    {
      "id": "BK004",
      "customerName": "James Wilson",
      "customerEmail": "j.wilson@email.com",
      "customerPhone": "+1 (555) 234-5678",
      "service": "Manicure & Pedicure",
      "date": "2024-01-22",
      "time": "16:00",
      "duration": 90,
      "price": 75.0,
      "status": "confirmed",
      "notes": "",
      "createdAt": "2024-01-17T11:20:00Z",
      "staffMember": "Anna Thompson"
    },
    {
      "id": "BK005",
      "customerName": "Rebecca Martinez",
      "customerEmail": "r.martinez@email.com",
      "customerPhone": "+1 (555) 345-6789",
      "service": "Hair Coloring",
      "date": "2024-01-19",
      "time": "09:30",
      "duration": 180,
      "price": 150.0,
      "status": "cancelled",
      "notes": "Balayage highlights requested",
      "createdAt": "2024-01-12T13:30:00Z",
      "staffMember": "Emma Wilson"
    },
    {
      "id": "BK006",
      "customerName": "David Kim",
      "customerEmail": "david.kim@email.com",
      "customerPhone": "+1 (555) 567-8901",
      "service": "Swedish Massage",
      "date": "2024-01-21",
      "time": "13:00",
      "duration": 60,
      "price": 90.0,
      "status": "confirmed",
      "notes": "First time client",
      "createdAt": "2024-01-18T10:15:00Z",
      "staffMember": "David Rodriguez"
    },
  ];

  List<Map<String, dynamic>> get filteredBookings {
    return bookings.where((booking) {
      bool matchesFilter = selectedFilter == "all" || booking["status"] == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty ||
          booking["customerName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking["service"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          booking["id"].toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesFilter && matchesSearch;
    }).toList()..sort((a, b) {
      return DateTime.parse(b["createdAt"]).compareTo(DateTime.parse(a["createdAt"]));
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "pending":
        return warningColor;
      case "completed":
        return infoColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "confirmed":
        return "Confirmed";
      case "pending":
        return "Pending";
      case "completed":
        return "Completed";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  Future<void> _updateBookingStatus(String bookingId, String newStatus) async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    // Update booking status
    int index = bookings.indexWhere((b) => b["id"] == bookingId);
    if (index != -1) {
      bookings[index]["status"] = newStatus;
    }
    
    hideLoading();
    setState(() {});
    
    ss("Booking status updated successfully");
  }

  Future<void> _deleteBooking(String bookingId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this booking?");
    if (!isConfirmed) return;

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    // Remove booking
    bookings.removeWhere((b) => b["id"] == bookingId);
    
    hideLoading();
    setState(() {});
    
    ss("Booking deleted successfully");
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Booking Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Booking ID", booking["id"]),
              _buildDetailRow("Customer", booking["customerName"]),
              _buildDetailRow("Email", booking["customerEmail"]),
              _buildDetailRow("Phone", booking["customerPhone"]),
              _buildDetailRow("Service", booking["service"]),
              _buildDetailRow("Date", DateTime.parse(booking["date"]).dMMMy),
              _buildDetailRow("Time", booking["time"]),
              _buildDetailRow("Duration", "${booking["duration"]} minutes"),
              _buildDetailRow("Price", "\$${(booking["price"] as double).toStringAsFixed(2)}"),
              _buildDetailRow("Staff", booking["staffMember"]),
              _buildDetailRow("Status", _getStatusLabel(booking["status"])),
              if (booking["notes"].isNotEmpty)
                _buildDetailRow("Notes", booking["notes"]),
              _buildDetailRow("Created", DateTime.parse(booking["createdAt"]).dMMMy),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Bookings"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create booking
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.event_available, color: Colors.white, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${bookings.where((b) => b["status"] == "confirmed").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Confirmed",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(50),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.schedule, color: Colors.white, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${bookings.where((b) => b["status"] == "pending").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(50),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.attach_money, color: Colors.white, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "\$${bookings.where((b) => b["status"] == "completed").fold(0.0, (sum, b) => sum + (b["price"] as double)).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filter
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.search, color: primaryColor),
                      SizedBox(width: spSm),
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
                    ],
                  ),
                  SizedBox(height: spSm),
                  QCategoryPicker(
                    items: [
                      {"label": "All", "value": "all"},
                      {"label": "Confirmed", "value": "confirmed"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Cancelled", "value": "cancelled"},
                    ],
                    value: selectedFilter,
                    onChanged: (index, label, value, item) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Results Count
            Row(
              children: [
                Text(
                  "${filteredBookings.length} bookings found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                PopupMenuButton(
                  icon: Icon(Icons.sort, color: primaryColor),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Sort by Date"),
                      onTap: () {
                        // Sort implementation
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Sort by Status"),
                      onTap: () {
                        // Sort implementation
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Sort by Price"),
                      onTap: () {
                        // Sort implementation
                      },
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Bookings List
            Column(
              children: filteredBookings.map((booking) {
                Color statusColor = _getStatusColor(booking["status"]);
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Booking Header
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        booking["id"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          _getStatusLabel(booking["status"]),
                                          style: TextStyle(
                                            color: statusColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    booking["customerName"],
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    booking["service"],
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
                                  "\$${(booking["price"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(booking["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  booking["time"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Booking Details
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              booking["staffMember"],
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${booking["duration"]} min",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (booking["notes"].isNotEmpty) ...[
                              SizedBox(width: spSm),
                              Icon(Icons.note, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  booking["notes"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Action Buttons
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(20),
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
                                onPressed: () => _showBookingDetails(booking),
                              ),
                            ),
                            SizedBox(width: spSm),
                            if (booking["status"] == "pending")
                              Expanded(
                                child: QButton(
                                  label: "Confirm",
                                  size: bs.sm,
                                  onPressed: () => _updateBookingStatus(booking["id"], "confirmed"),
                                ),
                              ),
                            if (booking["status"] == "confirmed")
                              Expanded(
                                child: QButton(
                                  label: "Complete",
                                  size: bs.sm,
                                  onPressed: () => _updateBookingStatus(booking["id"], "completed"),
                                ),
                              ),
                            SizedBox(width: spSm),
                            PopupMenuButton(
                              icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 16),
                                      SizedBox(width: spSm),
                                      Text("Edit"),
                                    ],
                                  ),
                                  onTap: () {
                                    // Edit booking
                                  },
                                ),
                                if (booking["status"] != "cancelled")
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Icon(Icons.cancel, size: 16),
                                        SizedBox(width: spSm),
                                        Text("Cancel"),
                                      ],
                                    ),
                                    onTap: () => _updateBookingStatus(booking["id"], "cancelled"),
                                  ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, size: 16, color: dangerColor),
                                      SizedBox(width: spSm),
                                      Text("Delete", style: TextStyle(color: dangerColor)),
                                    ],
                                  ),
                                  onTap: () => _deleteBooking(booking["id"]),
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
            
            // Load More or Empty State
            if (filteredBookings.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
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
    );
  }
}
