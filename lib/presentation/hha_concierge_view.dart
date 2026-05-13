import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaConciergeView extends StatefulWidget {
  const HhaConciergeView({super.key});

  @override
  State<HhaConciergeView> createState() => _HhaConciergeViewState();
}

class _HhaConciergeViewState extends State<HhaConciergeView> {
  int selectedTab = 0;
  String searchQuery = "";

  List<Map<String, dynamic>> conciergeServices = [
    {
      "id": "conc_001",
      "title": "Restaurant Reservations",
      "description": "Book tables at the finest restaurants in the city",
      "icon": Icons.restaurant,
      "category": "dining",
      "availability": "24/7",
      "response_time": "Within 30 minutes",
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
    },
    {
      "id": "conc_002",
      "title": "Event Tickets",
      "description": "Secure tickets for concerts, shows, and sports events",
      "icon": Icons.confirmation_number,
      "category": "entertainment",
      "availability": "Business hours",
      "response_time": "Within 2 hours",
      "image": "https://picsum.photos/300/200?random=2&keyword=concert",
    },
    {
      "id": "conc_003",
      "title": "Local Tours & Sightseeing",
      "description": "Customized city tours and sightseeing recommendations",
      "icon": Icons.tour,
      "category": "tourism",
      "availability": "Daily",
      "response_time": "Within 1 hour",
      "image": "https://picsum.photos/300/200?random=3&keyword=tour",
    },
    {
      "id": "conc_004",
      "title": "Shopping Assistance",
      "description": "Personal shopping services and boutique recommendations",
      "icon": Icons.shopping_bag,
      "category": "shopping",
      "availability": "Daily 9 AM - 8 PM",
      "response_time": "Within 1 hour",
      "image": "https://picsum.photos/300/200?random=4&keyword=shopping",
    },
    {
      "id": "conc_005",
      "title": "Business Services",
      "description": "Meeting arrangements, translation, and business support",
      "icon": Icons.business,
      "category": "business",
      "availability": "Business hours",
      "response_time": "Within 45 minutes",
      "image": "https://picsum.photos/300/200?random=5&keyword=business",
    },
    {
      "id": "conc_006",
      "title": "Emergency Assistance",
      "description": "24/7 support for urgent requests and emergencies",
      "icon": Icons.emergency,
      "category": "emergency",
      "availability": "24/7",
      "response_time": "Immediate",
      "image": "https://picsum.photos/300/200?random=6&keyword=emergency",
    },
  ];

  List<Map<String, dynamic>> recentRequests = [
    {
      "id": "req_001",
      "service": "Restaurant Reservations",
      "request": "Table for 4 at La Bernardin, tomorrow 7 PM",
      "status": "completed",
      "created_at": "2024-12-21T10:30:00",
      "completed_at": "2024-12-21T11:00:00",
      "concierge_name": "Sarah Wilson",
      "notes": "Reserved premium table with city view. Confirmation #RSV-12345",
    },
    {
      "id": "req_002",
      "service": "Event Tickets",
      "request": "2 tickets for Broadway show - The Lion King",
      "status": "in_progress",
      "created_at": "2024-12-21T14:15:00",
      "concierge_name": "Michael Chen",
      "notes": "Checking availability for this weekend shows",
    },
    {
      "id": "req_003",
      "service": "Local Tours",
      "request": "Half-day city tour for 3 people including museums",
      "status": "pending",
      "created_at": "2024-12-21T16:45:00",
      "concierge_name": "Emma Rodriguez",
      "notes": "Awaiting your confirmation on preferred date",
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Call Concierge",
      "icon": Icons.phone,
      "color": primaryColor,
      "action": "call",
    },
    {
      "title": "Chat Support",
      "icon": Icons.chat,
      "color": infoColor,
      "action": "chat",
    },
    {
      "title": "Email Request",
      "icon": Icons.email,
      "color": warningColor,
      "action": "email",
    },
    {
      "title": "Emergency",
      "icon": Icons.warning,
      "color": dangerColor,
      "action": "emergency",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "call":
        ss("Calling concierge...");
        break;
      case "chat":
        // Navigate to chat
        break;
      case "email":
        // Navigate to email form
        break;
      case "emergency":
        ss("Connecting to emergency services...");
        break;
    }
  }

  void _requestService(Map<String, dynamic> service) {
    // Navigate to service request form
    ss("Opening request form for ${service["title"]}...");
  }

  void _viewRequestDetails(Map<String, dynamic> request) {
    // Navigate to request details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Concierge Services"),
        actions: [
          IconButton(
            onPressed: () {
              // View all requests
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.room_service,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spSm),
                Text(
                  "Personal Concierge at Your Service",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "We're here to make your stay exceptional. How can we assist you today?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: quickActions.map((action) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _handleQuickAction(action["action"]),
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: (action["color"] as Color).withAlpha(40)),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                action["icon"],
                                color: action["color"] as Color,
                                size: 24,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                action["title"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: action["color"] as Color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Tab Selection
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == 0 ? primaryColor : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        "Services",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                          color: selectedTab == 0 ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == 1 ? primaryColor : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        "My Requests",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                          color: selectedTab == 1 ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: selectedTab == 0 ? _buildServicesTab() : _buildRequestsTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search Bar
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search services...",
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

          // Services Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: conciergeServices.map((service) {
              return _buildServiceCard(service);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    return recentRequests.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No Recent Requests",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Your concierge requests will appear here",
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
            itemCount: recentRequests.length,
            itemBuilder: (context, index) {
              final request = recentRequests[index];
              return _buildRequestCard(request);
            },
          );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${service["image"]}",
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(service["icon"], color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${service["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Text(
                  "${service["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${service["availability"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.timer, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Response: ${service["response_time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Request Service",
                    size: bs.sm,
                    onPressed: () => _requestService(service),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${request["service"]}",
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
                  color: _getStatusColor(request["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusText(request["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(request["status"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          Text(
            "${request["request"]}",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          
          if (request["notes"] != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Concierge Notes:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "${request["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Handled by: ${request["concierge_name"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${(DateTime.parse(request["created_at"])).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () => _viewRequestDetails(request),
            ),
          ),
        ],
      ),
    );
  }
}
