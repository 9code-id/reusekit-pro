import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaTelemedicineView extends StatefulWidget {
  const HcaTelemedicineView({super.key});

  @override
  State<HcaTelemedicineView> createState() => _HcaTelemedicineViewState();
}

class _HcaTelemedicineViewState extends State<HcaTelemedicineView> {
  bool loading = false;
  int selectedTab = 0;
  String selectedSpecialty = "All";
  String selectedType = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> specialties = [
    {"label": "All", "value": "All"},
    {"label": "General Practice", "value": "General Practice"},
    {"label": "Cardiology", "value": "Cardiology"},
    {"label": "Dermatology", "value": "Dermatology"},
    {"label": "Psychiatry", "value": "Psychiatry"},
    {"label": "Pediatrics", "value": "Pediatrics"},
  ];

  List<Map<String, dynamic>> appointmentTypes = [
    {"label": "All", "value": "All"},
    {"label": "Video Call", "value": "Video Call"},
    {"label": "Phone Call", "value": "Phone Call"},
    {"label": "Chat", "value": "Chat"},
  ];

  List<Map<String, dynamic>> doctors = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiology",
      "rating": 4.9,
      "experience": 15,
      "consultations": 2500,
      "price": 150,
      "avatar": "https://picsum.photos/100/100?random=1&face",
      "available": true,
      "nextAvailable": "Today, 2:30 PM",
      "languages": ["English", "Spanish"],
      "verified": true,
    },
    {
      "id": 2,
      "name": "Dr. Michael Chen",
      "specialty": "Dermatology",
      "rating": 4.8,
      "experience": 12,
      "consultations": 1800,
      "price": 120,
      "avatar": "https://picsum.photos/100/100?random=2&face",
      "available": true,
      "nextAvailable": "Tomorrow, 9:00 AM",
      "languages": ["English", "Mandarin"],
      "verified": true,
    },
    {
      "id": 3,
      "name": "Dr. Emily Rodriguez",
      "specialty": "Psychiatry",
      "rating": 4.7,
      "experience": 10,
      "consultations": 1200,
      "price": 180,
      "avatar": "https://picsum.photos/100/100?random=3&face",
      "available": false,
      "nextAvailable": "Monday, 11:00 AM",
      "languages": ["English", "Spanish"],
      "verified": true,
    },
    {
      "id": 4,
      "name": "Dr. David Wilson",
      "specialty": "General Practice",
      "rating": 4.6,
      "experience": 8,
      "consultations": 900,
      "price": 100,
      "avatar": "https://picsum.photos/100/100?random=4&face",
      "available": true,
      "nextAvailable": "Today, 4:00 PM",
      "languages": ["English"],
      "verified": true,
    },
  ];

  List<Map<String, dynamic>> upcomingAppointments = [
    {
      "id": 1,
      "doctorName": "Dr. Sarah Johnson",
      "specialty": "Cardiology",
      "date": "Today",
      "time": "2:30 PM",
      "type": "Video Call",
      "status": "Confirmed",
      "avatar": "https://picsum.photos/100/100?random=1&face",
    },
    {
      "id": 2,
      "doctorName": "Dr. Michael Chen",
      "specialty": "Dermatology",
      "date": "Tomorrow",
      "time": "9:00 AM",
      "type": "Chat",
      "status": "Pending",
      "avatar": "https://picsum.photos/100/100?random=2&face",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Telemedicine",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Find Doctors", icon: Icon(Icons.search)),
        Tab(text: "Appointments", icon: Icon(Icons.calendar_today)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildFindDoctorsTab(),
        _buildAppointmentsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildFindDoctorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search doctors...",
                  value: searchQuery,
                  hint: "Search by name or specialty",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFilters();
                },
              ),
            ],
          ),

          // Quick Filters
          Text(
            "Specialty",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: specialties,
            value: selectedSpecialty,
            onChanged: (index, label, value, item) {
              selectedSpecialty = value;
              setState(() {});
            },
          ),

          // Available Now Section
          Row(
            children: [
              Text(
                "Available Now",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // View all
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Doctors List
          ...doctors.map((doctor) => _buildDoctorCard(doctor)),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${doctor["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${doctor["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (doctor["verified"] as bool)
                          Container(
                            margin: EdgeInsets.only(left: spXs),
                            child: Icon(
                              Icons.verified,
                              color: successColor,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${doctor["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Text(
                          "${doctor["rating"]} (${doctor["consultations"]} consultations)",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (doctor["available"] as bool) ? successColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      (doctor["available"] as bool) ? "Available" : "Busy",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${(doctor["price"] as int)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Next: ${doctor["nextAvailable"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(doctor["languages"] as List).join(", ")}",
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
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {
                    _viewDoctorProfile(doctor);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: (doctor["available"] as bool) ? "Book Now" : "Schedule",
                  size: bs.sm,
                  onPressed: () {
                    _bookAppointment(doctor);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Upcoming", "${upcomingAppointments.length}", Icons.schedule, primaryColor),
              _buildStatCard("Completed", "24", Icons.check_circle, successColor),
              _buildStatCard("Cancelled", "2", Icons.cancel, dangerColor),
            ],
          ),

          // Upcoming Appointments
          Text(
            "Upcoming Appointments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (upcomingAppointments.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No upcoming appointments",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Schedule Appointment",
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        selectedTab = 0;
                      });
                    },
                  ),
                ],
              ),
            )
          else
            ...upcomingAppointments.map((appointment) => _buildAppointmentCard(appointment)),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("${appointment["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${appointment["doctorName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${appointment["specialty"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${appointment["date"]} at ${appointment["time"]}",
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: appointment["status"] == "Confirmed" ? successColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${appointment["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${appointment["type"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Filter Options
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Month",
                  items: [
                    {"label": "All Time", "value": "all"},
                    {"label": "This Month", "value": "this_month"},
                    {"label": "Last Month", "value": "last_month"},
                    {"label": "Last 3 Months", "value": "last_3_months"},
                  ],
                  value: "all",
                  onChanged: (value, label) {
                    // Filter appointments
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Type",
                  items: appointmentTypes,
                  value: "All",
                  onChanged: (value, label) {
                    // Filter appointments
                  },
                ),
              ),
            ],
          ),

          // History List
          Text(
            "Consultation History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Placeholder for history items
          ...List.generate(5, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/100/100?random=${index + 10}&face"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. ${["Johnson", "Chen", "Rodriguez", "Wilson", "Davis"][index]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${["Cardiology", "Dermatology", "Psychiatry", "General", "Pediatrics"][index]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${["Jan 15, 2024", "Jan 10, 2024", "Jan 5, 2024", "Dec 28, 2023", "Dec 20, 2023"][index]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // View consultation details
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilters() {
    // Show filter dialog
  }

  void _viewDoctorProfile(Map<String, dynamic> doctor) {
    // Navigate to doctor profile
  }

  void _bookAppointment(Map<String, dynamic> doctor) {
    // Navigate to booking page
  }
}
