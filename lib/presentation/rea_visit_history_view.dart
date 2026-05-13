import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaVisitHistoryView extends StatefulWidget {
  const ReaVisitHistoryView({super.key});

  @override
  State<ReaVisitHistoryView> createState() => _ReaVisitHistoryViewState();
}

class _ReaVisitHistoryViewState extends State<ReaVisitHistoryView> {
  String selectedFilter = "All";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Upcoming", "value": "Upcoming"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
    {"label": "Rescheduled", "value": "Rescheduled"},
  ];

  List<Map<String, dynamic>> visits = [
    {
      "id": "1",
      "property": {
        "title": "Modern Luxury Villa",
        "address": "123 Ocean Drive, Miami Beach",
        "image": "https://picsum.photos/300/200?random=101&keyword=villa",
        "price": 2500000,
      },
      "agent": {
        "name": "Sarah Johnson",
        "phone": "+1 234 567 8900",
        "image": "https://picsum.photos/100/100?random=201&keyword=agent",
      },
      "date": "2025-06-20",
      "time": "10:00",
      "status": "Upcoming",
      "type": "Physical Visit",
      "notes": "Interested in the garden area and security features",
      "guests": 2,
      "confirmation_code": "VH001234",
    },
    {
      "id": "2",
      "property": {
        "title": "Downtown Apartment",
        "address": "456 Main Street, Downtown",
        "image": "https://picsum.photos/300/200?random=102&keyword=apartment",
        "price": 850000,
      },
      "agent": {
        "name": "Michael Chen",
        "phone": "+1 234 567 8901",
        "image": "https://picsum.photos/100/100?random=202&keyword=agent",
      },
      "date": "2025-06-10",
      "time": "14:30",
      "status": "Completed",
      "type": "Virtual Tour",
      "notes": "Great location, considering making an offer",
      "guests": 1,
      "confirmation_code": "VH001235",
      "feedback_rating": 5,
      "feedback": "Excellent tour, very detailed and informative",
    },
    {
      "id": "3",
      "property": {
        "title": "Suburban House",
        "address": "789 Pine Street, Suburbia",
        "image": "https://picsum.photos/300/200?random=103&keyword=house",
        "price": 650000,
      },
      "agent": {
        "name": "Emily Davis",
        "phone": "+1 234 567 8902",
        "image": "https://picsum.photos/100/100?random=203&keyword=agent",
      },
      "date": "2025-06-05",
      "time": "11:00",
      "status": "Cancelled",
      "type": "Physical Visit",
      "notes": "Cancelled due to scheduling conflict",
      "guests": 3,
      "confirmation_code": "VH001236",
      "cancelled_reason": "Personal emergency",
    },
    {
      "id": "4",
      "property": {
        "title": "Waterfront Condo",
        "address": "321 Beach Road, Seaside",
        "image": "https://picsum.photos/300/200?random=104&keyword=condo",
        "price": 1200000,
      },
      "agent": {
        "name": "David Wilson",
        "phone": "+1 234 567 8903",
        "image": "https://picsum.photos/100/100?random=204&keyword=agent",
      },
      "date": "2025-06-25",
      "time": "16:00",
      "status": "Rescheduled",
      "type": "Physical Visit",
      "notes": "Originally scheduled for June 18th",
      "guests": 2,
      "confirmation_code": "VH001237",
      "original_date": "2025-06-18",
    },
    {
      "id": "5",
      "property": {
        "title": "City Penthouse",
        "address": "555 Sky Tower, City Center",
        "image": "https://picsum.photos/300/200?random=105&keyword=penthouse",
        "price": 3500000,
      },
      "agent": {
        "name": "Sarah Johnson",
        "phone": "+1 234 567 8900",
        "image": "https://picsum.photos/100/100?random=201&keyword=agent",
      },
      "date": "2025-05-28",
      "time": "09:30",
      "status": "Completed",
      "type": "Physical Visit",
      "notes": "Loved the view and modern amenities",
      "guests": 1,
      "confirmation_code": "VH001238",
      "feedback_rating": 4,
      "feedback": "Great property but slightly overpriced",
    },
  ];

  List<Map<String, dynamic>> get filteredVisits {
    List<Map<String, dynamic>> result = visits;
    
    if (selectedFilter != "All") {
      result = result.where((visit) => visit["status"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      result = result.where((visit) => 
        (visit["property"]["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (visit["property"]["address"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (visit["agent"]["name"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return result..sort((a, b) => DateTime.parse("${b["date"]}").compareTo(DateTime.parse("${a["date"]}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visit History"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                _buildSearchAndFilter(),
                _buildSummaryStats(),
                _buildVisitsList(),
              ],
            ),
          ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          QTextField(
            label: "Search visits",
            value: searchQuery,
            hint: "Property name, location, or agent",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QCategoryPicker(
            items: filterOptions,
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

  Widget _buildSummaryStats() {
    int upcoming = visits.where((v) => v["status"] == "Upcoming").length;
    int completed = visits.where((v) => v["status"] == "Completed").length;
    int cancelled = visits.where((v) => v["status"] == "Cancelled").length;
    int rescheduled = visits.where((v) => v["status"] == "Rescheduled").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visit Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Upcoming", upcoming, warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Completed", completed, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Cancelled", cancelled, dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Rescheduled", rescheduled, infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitsList() {
    if (filteredVisits.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(Icons.event_busy, size: 64, color: disabledColor),
            SizedBox(height: spMd),
            Text(
              "No visits found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filter criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: filteredVisits.map((visit) => _buildVisitCard(visit)).toList(),
    );
  }

  Widget _buildVisitCard(Map<String, dynamic> visit) {
    Color statusColor = _getStatusColor("${visit["status"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${visit["property"]["image"]}",
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${visit["property"]["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${visit["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${visit["property"]["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((visit["property"]["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildVisitDetails(visit),
          SizedBox(height: spMd),
          _buildVisitActions(visit),
        ],
      ),
    );
  }

  Widget _buildVisitDetails(Map<String, dynamic> visit) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      DateTime.parse("${visit["date"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "${visit["time"]}",
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.person, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "${visit["agent"]["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.group, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "${visit["guests"]} guests",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (visit["notes"] != null && (visit["notes"] as String).isNotEmpty) ...[
            SizedBox(height: spSm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.note, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${visit["notes"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVisitActions(Map<String, dynamic> visit) {
    String status = "${visit["status"]}";
    
    return Row(
      children: [
        if (status == "Upcoming") ...[
          Expanded(
            child: QButton(
              label: "Reschedule",
              size: bs.sm,
              onPressed: () => _rescheduleVisit(visit),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () => _cancelVisit(visit),
            ),
          ),
        ] else if (status == "Completed" && visit["feedback_rating"] == null) ...[
          Expanded(
            child: QButton(
              label: "Rate Visit",
              size: bs.sm,
              onPressed: () => _rateVisit(visit),
            ),
          ),
        ] else if (status == "Cancelled") ...[
          Expanded(
            child: QButton(
              label: "Book Again",
              size: bs.sm,
              onPressed: () => _bookAgain(visit),
            ),
          ),
        ],
        SizedBox(width: spSm),
        QButton(
          icon: Icons.phone,
          size: bs.sm,
          onPressed: () => _contactAgent(visit),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.more_vert,
          size: bs.sm,
          onPressed: () => _showMoreOptions(visit),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Upcoming":
        return warningColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      case "Rescheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _rescheduleVisit(Map<String, dynamic> visit) {
    ss("Redirecting to reschedule page...");
  }

  void _cancelVisit(Map<String, dynamic> visit) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this visit?");
    if (isConfirmed) {
      ss("Visit cancelled successfully");
    }
  }

  void _rateVisit(Map<String, dynamic> visit) {
    ss("Opening rating form...");
  }

  void _bookAgain(Map<String, dynamic> visit) {
    ss("Redirecting to booking page...");
  }

  void _contactAgent(Map<String, dynamic> visit) {
    ss("Calling ${visit["agent"]["name"]}...");
  }

  void _showMoreOptions(Map<String, dynamic> visit) {
    ss("Showing more options...");
  }
}
