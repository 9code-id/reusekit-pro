import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaEventBookingView extends StatefulWidget {
  const FmaEventBookingView({super.key});

  @override
  State<FmaEventBookingView> createState() => _FmaEventBookingViewState();
}

class _FmaEventBookingViewState extends State<FmaEventBookingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedEventType = "all";

  List<Map<String, dynamic>> eventBookings = [
    {
      "id": "EVT001",
      "event_name": "Smith Family Reunion",
      "client_name": "Michael Smith",
      "event_type": "Family Gathering",
      "status": "Confirmed",
      "event_date": "2024-06-25",
      "event_time": "12:00 PM",
      "guests_count": 45,
      "venue": "Sunset Gardens Hall",
      "budget": 2500.00,
      "menu_type": "Buffet",
      "dietary_requirements": ["Vegetarian Options", "Gluten-Free"],
      "special_requests": "Birthday cake for grandmother's 80th",
      "deposit_paid": 750.00,
      "balance_due": 1750.00,
      "contact_phone": "+1 (555) 123-4567",
      "contact_email": "michael.smith@email.com",
      "booking_date": "2024-05-15",
      "setup_time": "10:00 AM",
      "cleanup_time": "4:00 PM",
      "assigned_staff": ["Chef Marco", "Server Team A", "Event Coordinator Sarah"]
    },
    {
      "id": "EVT002",
      "event_name": "Johnson Corporate Meeting",
      "client_name": "Lisa Johnson",
      "event_type": "Corporate",
      "status": "Pending",
      "event_date": "2024-06-22",
      "event_time": "9:00 AM",
      "guests_count": 25,
      "venue": "Downtown Conference Center",
      "budget": 1800.00,
      "menu_type": "Continental Breakfast & Lunch",
      "dietary_requirements": ["Keto Options", "Dairy-Free"],
      "special_requests": "Coffee service throughout the day",
      "deposit_paid": 0.00,
      "balance_due": 1800.00,
      "contact_phone": "+1 (555) 987-6543",
      "contact_email": "lisa.johnson@company.com",
      "booking_date": "2024-06-18",
      "setup_time": "7:00 AM",
      "cleanup_time": "2:00 PM",
      "assigned_staff": ["Chef Isabella", "Service Team B"]
    },
    {
      "id": "EVT003",
      "event_name": "Williams Wedding Reception",
      "client_name": "Emma Williams",
      "event_type": "Wedding",
      "status": "Planning",
      "event_date": "2024-07-15",
      "event_time": "6:00 PM",
      "guests_count": 120,
      "venue": "Grand Ballroom Hotel",
      "budget": 8500.00,
      "menu_type": "Plated Dinner",
      "dietary_requirements": ["Vegan Options", "Nut-Free"],
      "special_requests": "Wedding cake, champagne toast, late night snacks",
      "deposit_paid": 2550.00,
      "balance_due": 5950.00,
      "contact_phone": "+1 (555) 456-7890",
      "contact_email": "emma.williams@email.com",
      "booking_date": "2024-04-20",
      "setup_time": "2:00 PM",
      "cleanup_time": "12:00 AM",
      "assigned_staff": ["Head Chef David", "Full Service Team", "Event Manager"]
    },
    {
      "id": "EVT004",
      "event_name": "Tech Startup Launch Party",
      "client_name": "Alex Chen",
      "event_type": "Corporate",
      "status": "Completed",
      "event_date": "2024-06-10",
      "event_time": "7:00 PM",
      "guests_count": 80,
      "venue": "Innovation Hub",
      "budget": 4200.00,
      "menu_type": "Cocktail Reception",
      "dietary_requirements": ["Organic Options"],
      "special_requests": "Branded desserts with company logo",
      "deposit_paid": 4200.00,
      "balance_due": 0.00,
      "contact_phone": "+1 (555) 234-5678",
      "contact_email": "alex.chen@startup.com",
      "booking_date": "2024-05-01",
      "setup_time": "4:00 PM",
      "cleanup_time": "11:00 PM",
      "assigned_staff": ["Chef Sarah", "Bartender Team", "Service Crew"]
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Planning", "value": "Planning"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> eventTypeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Wedding", "value": "Wedding"},
    {"label": "Corporate", "value": "Corporate"},
    {"label": "Family Gathering", "value": "Family Gathering"},
    {"label": "Birthday Party", "value": "Birthday Party"},
    {"label": "Social Event", "value": "Social Event"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Event Booking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Bookings", icon: Icon(Icons.event)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
        Tab(text: "Packages", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildBookingsTab(),
        _buildCalendarTab(),
        _buildPackagesTab(),
      ],
    );
  }

  Widget _buildBookingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildBookingsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search events...",
                value: searchQuery,
                hint: "Search by event name, client, or booking ID",
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
              onPressed: () {},
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: statusItems,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Event Type",
                items: eventTypeItems,
                value: selectedEventType,
                onChanged: (value, label) {
                  selectedEventType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookingsList() {
    return Column(
      spacing: spSm,
      children: eventBookings.map((booking) => _buildBookingCard(booking)).toList(),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor = _getStatusColor("${booking["status"]}");
    double budget = booking["budget"] as double;
    double depositPaid = booking["deposit_paid"] as double;
    double balanceDue = booking["balance_due"] as double;
    int guestsCount = booking["guests_count"] as int;
    List<String> dietaryRequirements = (booking["dietary_requirements"] as List).cast<String>();
    List<String> assignedStaff = (booking["assigned_staff"] as List).cast<String>();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${booking["event_name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${booking["id"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${booking["event_type"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${booking["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${booking["client_name"]}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Icon(Icons.group, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "$guestsCount guests",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today, size: 20, color: primaryColor),
                      SizedBox(height: spXs),
                      Text(
                        "${booking["event_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${booking["event_time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.location_on, size: 20, color: infoColor),
                      SizedBox(height: spXs),
                      Text(
                        "${booking["venue"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.restaurant, size: 20, color: successColor),
                      SizedBox(height: spXs),
                      Text(
                        "${booking["menu_type"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${booking["contact_phone"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.email, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${booking["contact_email"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "\$${budget.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Total Budget",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "\$${depositPaid.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Paid",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "\$${balanceDue.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: balanceDue > 0 ? dangerColor : successColor,
                        ),
                      ),
                      Text(
                        "Balance Due",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (dietaryRequirements.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Dietary Requirements:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: dietaryRequirements.map((requirement) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          requirement,
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          if (booking["special_requests"] != null && "${booking["special_requests"]}".isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 16, color: primaryColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Special: ${booking["special_requests"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Assigned Staff:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  children: assignedStaff.map((staff) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        staff,
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Setup: ${booking["setup_time"]} | Cleanup: ${booking["cleanup_time"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Edit Booking",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "June 2024 Event Calendar",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 300,
                  child: Center(
                    child: Text(
                      "Calendar view showing all scheduled events",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Upcoming Events This Week",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildUpcomingEvent("Johnson Corporate Meeting", "June 22", "25 guests", warningColor),
                _buildUpcomingEvent("Smith Family Reunion", "June 25", "45 guests", successColor),
                _buildUpcomingEvent("Roberts Birthday Party", "June 28", "30 guests", infoColor),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildCalendarMetric("This Week", "3", Icons.event, primaryColor),
              _buildCalendarMetric("This Month", "12", Icons.calendar_month, infoColor),
              _buildCalendarMetric("Confirmed", "8", Icons.check_circle, successColor),
              _buildCalendarMetric("Pending", "4", Icons.pending, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvent(String eventName, String date, String guests, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      guests,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildCalendarMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Wedding Packages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPackageItem(
                  "Intimate Wedding",
                  "50-75 guests",
                  "\$4,500 - \$6,000",
                  ["3-course plated dinner", "Cocktail hour", "Wedding cake", "Basic floral"],
                  warningColor,
                ),
                _buildPackageItem(
                  "Classic Wedding",
                  "75-125 guests",
                  "\$7,500 - \$12,000",
                  ["4-course plated dinner", "Open bar", "Wedding cake", "Premium floral", "DJ service"],
                  infoColor,
                ),
                _buildPackageItem(
                  "Luxury Wedding",
                  "125+ guests",
                  "\$15,000+",
                  ["5-course gourmet dinner", "Premium open bar", "Custom cake", "Luxury floral", "Live band", "Photography"],
                  dangerColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Corporate Packages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPackageItem(
                  "Business Meeting",
                  "10-30 attendees",
                  "\$800 - \$1,500",
                  ["Continental breakfast", "Coffee service", "Working lunch", "A/V equipment"],
                  successColor,
                ),
                _buildPackageItem(
                  "Corporate Event",
                  "30-100 attendees",
                  "\$2,500 - \$5,000",
                  ["Welcome reception", "Plated lunch/dinner", "Open bar", "Entertainment", "Team activities"],
                  primaryColor,
                ),
                _buildPackageItem(
                  "Annual Gala",
                  "100+ attendees",
                  "\$8,000+",
                  ["Cocktail reception", "Multi-course dinner", "Premium bar", "Live entertainment", "Awards ceremony"],
                  warningColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Social Event Packages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPackageItem(
                  "Birthday Party",
                  "15-40 guests",
                  "\$1,200 - \$2,500",
                  ["Buffet dinner", "Custom cake", "Decorations", "Party favors"],
                  infoColor,
                ),
                _buildPackageItem(
                  "Anniversary Celebration",
                  "25-60 guests",
                  "\$2,000 - \$4,000",
                  ["Cocktail hour", "Plated dinner", "Anniversary cake", "Music system", "Photo display"],
                  successColor,
                ),
                _buildPackageItem(
                  "Graduation Party",
                  "20-50 guests",
                  "\$1,500 - \$3,000",
                  ["BBQ or buffet", "Graduation cake", "Photo booth", "Decorations in school colors"],
                  primaryColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Add-On Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildAddonItem("Premium Bar Service", "\$15/person", Icons.local_bar),
                _buildAddonItem("Professional Photography", "\$800-1500", Icons.camera_alt),
                _buildAddonItem("Live Music/DJ", "\$600-1200", Icons.music_note),
                _buildAddonItem("Floral Arrangements", "\$300-800", Icons.local_florist),
                _buildAddonItem("Specialty Lighting", "\$400-1000", Icons.lightbulb),
                _buildAddonItem("Photo Booth", "\$500-800", Icons.photo_camera),
                _buildAddonItem("Valet Parking", "\$12/car", Icons.local_parking),
                _buildAddonItem("Custom Linens", "\$8-15/table", Icons.table_restaurant),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageItem(String title, String capacity, String price, List<String> inclusions, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(50)),
        borderRadius: BorderRadius.circular(radiusSm),
        color: color.withAlpha(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            capacity,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Includes:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: inclusions.map((inclusion) {
              return Padding(
                padding: EdgeInsets.only(left: spSm, top: 2),
                child: Row(
                  children: [
                    Icon(Icons.check, size: 16, color: color),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        inclusion,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Request Quote",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddonItem(String service, String price, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              service,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Planning":
        return infoColor;
      case "Confirmed":
        return successColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
