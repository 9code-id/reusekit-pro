import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCapacityManagementView extends StatefulWidget {
  const EcmCapacityManagementView({super.key});

  @override
  State<EcmCapacityManagementView> createState() => _EcmCapacityManagementViewState();
}

class _EcmCapacityManagementViewState extends State<EcmCapacityManagementView> {
  int currentTab = 0;
  bool isLoading = false;

  List<Map<String, dynamic>> venues = [
    {
      "id": 1,
      "name": "Grand Ballroom",
      "capacity": 500,
      "booked": 320,
      "available": 180,
      "price_per_person": 150.0,
      "status": "available",
      "layout": "Theater",
      "image": "https://picsum.photos/300/200?random=1&keyword=ballroom"
    },
    {
      "id": 2,
      "name": "Conference Hall A",
      "capacity": 200,
      "booked": 180,
      "available": 20,
      "price_per_person": 120.0,
      "status": "nearly_full",
      "layout": "Classroom",
      "image": "https://picsum.photos/300/200?random=2&keyword=conference"
    },
    {
      "id": 3,
      "name": "Meeting Room B",
      "capacity": 50,
      "booked": 50,
      "available": 0,
      "price_per_person": 80.0,
      "status": "full",
      "layout": "U-Shape",
      "image": "https://picsum.photos/300/200?random=3&keyword=meeting"
    },
    {
      "id": 4,
      "name": "Outdoor Pavilion",
      "capacity": 800,
      "booked": 250,
      "available": 550,
      "price_per_person": 200.0,
      "status": "available",
      "layout": "Open",
      "image": "https://picsum.photos/300/200?random=4&keyword=pavilion"
    }
  ];

  List<Map<String, dynamic>> bookingHistory = [
    {
      "event_name": "Tech Conference 2025",
      "venue": "Grand Ballroom",
      "attendees": 320,
      "date": "2025-07-15",
      "status": "confirmed",
      "revenue": 48000.0
    },
    {
      "event_name": "Sales Workshop",
      "venue": "Conference Hall A",
      "attendees": 180,
      "date": "2025-07-20",
      "status": "confirmed", 
      "revenue": 21600.0
    },
    {
      "event_name": "Team Building",
      "venue": "Meeting Room B",
      "attendees": 50,
      "date": "2025-07-25",
      "status": "pending",
      "revenue": 4000.0
    }
  ];

  Widget _buildCapacityCard(Map<String, dynamic> venue) {
    Color statusColor = venue["status"] == "available" 
        ? successColor 
        : venue["status"] == "nearly_full" 
            ? warningColor 
            : dangerColor;
    
    double occupancyRate = (venue["booked"] as int) / (venue["capacity"] as int);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
              image: DecorationImage(
                image: NetworkImage("${venue["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(102),
                  ],
                ),
              ),
              padding: EdgeInsets.all(spSm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${venue["name"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${venue["status"]}".replaceAll("_", " ").toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Capacity: ${venue["capacity"]} people",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.view_agenda, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${venue["layout"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Occupancy Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: occupancyRate,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(occupancyRate * 100).toInt()}% occupied",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((venue["price_per_person"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "per person",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${venue["booked"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Booked",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${venue["available"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _viewVenueDetails(venue),
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () => _editVenueCapacity(venue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingHistoryCard(Map<String, dynamic> booking) {
    Color statusColor = booking["status"] == "confirmed" 
        ? successColor 
        : booking["status"] == "pending" 
            ? warningColor 
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${booking["event_name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${booking["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.location_on, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${booking["venue"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(booking["date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.people, size: 16, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "${booking["attendees"]} attendees",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "\$${((booking["revenue"] as double)).currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalCapacity = venues.fold(0, (sum, venue) => sum + (venue["capacity"] as int));
    int totalBooked = venues.fold(0, (sum, venue) => sum + (venue["booked"] as int));
    int totalAvailable = venues.fold(0, (sum, venue) => sum + (venue["available"] as int));
    double totalRevenue = bookingHistory.fold(0.0, (sum, booking) => sum + (booking["revenue"] as double));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Capacity Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.business, color: primaryColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Capacity",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalCapacity",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "people",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.event_seat, color: successColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Booked",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalBooked",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "${((totalBooked / totalCapacity) * 100).toInt()}% occupied",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.event_available, color: infoColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalAvailable",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "${((totalAvailable / totalCapacity) * 100).toInt()}% available",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.attach_money, color: warningColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$${(totalRevenue).currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "total earnings",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Text(
                "Venue Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Venue",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _addNewVenue,
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...venues.map((venue) => _buildCapacityCard(venue)).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Booking History",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: _filterBookings,
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...bookingHistory.map((booking) => _buildBookingHistoryCard(booking)).toList(),
        ],
      ),
    );
  }

  void _viewVenueDetails(Map<String, dynamic> venue) {
    // Navigate to venue details
  }

  void _editVenueCapacity(Map<String, dynamic> venue) {
    // Navigate to edit venue capacity
  }

  void _addNewVenue() {
    // Navigate to add new venue
  }

  void _filterBookings() {
    // Show filter options
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Capacity Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildHistoryTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
