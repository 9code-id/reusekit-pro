import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaServiceBookingView extends StatefulWidget {
  const AmaServiceBookingView({super.key});

  @override
  State<AmaServiceBookingView> createState() => _AmaServiceBookingViewState();
}

class _AmaServiceBookingViewState extends State<AmaServiceBookingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedLocation = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> services = [
    {
      "id": "SRV001",
      "name": "Tractor Maintenance Service",
      "category": "Maintenance",
      "provider": "AgriTech Solutions",
      "rating": 4.8,
      "totalBookings": 234,
      "price": 150.00,
      "duration": "2-3 hours",
      "location": "On-site Service",
      "availability": "Available",
      "description": "Complete tractor maintenance including oil change, filter replacement, and system inspection",
      "services": ["Oil Change", "Filter Replacement", "System Inspection", "Fluid Top-up"],
      "certifications": ["ASE Certified", "John Deere Authorized", "CAT Certified"],
      "image": "https://picsum.photos/400/300?random=1&keyword=tractor",
      "contact": "+1 555-0123",
      "responseTime": "Within 2 hours",
      "workingHours": "Mon-Sat 7AM-6PM",
      "emergencyService": true,
      "warranty": "30 days",
      "icon": Icons.build
    },
    {
      "id": "SRV002",
      "name": "Crop Harvesting Service",
      "category": "Harvesting",
      "provider": "Harvest Masters",
      "rating": 4.9,
      "totalBookings": 156,
      "price": 85.00,
      "duration": "Per hectare",
      "location": "Field Service",
      "availability": "Available",
      "description": "Professional crop harvesting with modern equipment and experienced operators",
      "services": ["Grain Harvesting", "Crop Collection", "Field Cleaning", "Transport Arrangement"],
      "certifications": ["Agricultural Certificate", "Equipment Operator License"],
      "image": "https://picsum.photos/400/300?random=2&keyword=harvest",
      "contact": "+1 555-0456",
      "responseTime": "Within 24 hours",
      "workingHours": "Mon-Sun 6AM-8PM",
      "emergencyService": false,
      "warranty": "Crop quality guarantee",
      "icon": Icons.grass
    },
    {
      "id": "SRV003",
      "name": "Irrigation System Installation",
      "category": "Installation",
      "provider": "WaterTech Irrigation",
      "rating": 4.7,
      "totalBookings": 89,
      "price": 2500.00,
      "duration": "3-5 days",
      "location": "Field Installation",
      "availability": "Booked",
      "description": "Complete irrigation system design and installation for optimal water management",
      "services": ["System Design", "Pipe Installation", "Controller Setup", "Testing & Calibration"],
      "certifications": ["Irrigation Association Certified", "Licensed Contractor"],
      "image": "https://picsum.photos/400/300?random=3&keyword=irrigation",
      "contact": "+1 555-0789",
      "responseTime": "Within 48 hours",
      "workingHours": "Mon-Fri 8AM-5PM",
      "emergencyService": false,
      "warranty": "2 years",
      "icon": Icons.water_drop,
      "nextAvailable": "2025-07-15"
    },
    {
      "id": "SRV004",
      "name": "Soil Testing & Analysis",
      "category": "Testing",
      "provider": "AgriLab Services",
      "rating": 4.6,
      "totalBookings": 312,
      "price": 75.00,
      "duration": "Sample collection + 3 days lab",
      "location": "Field + Lab",
      "availability": "Available",
      "description": "Comprehensive soil analysis for optimal crop planning and fertilizer recommendations",
      "services": ["Soil Sampling", "pH Testing", "Nutrient Analysis", "Fertilizer Recommendations"],
      "certifications": ["Certified Lab", "Agricultural Testing Accredited"],
      "image": "https://picsum.photos/400/300?random=4&keyword=soil",
      "contact": "+1 555-0321",
      "responseTime": "Same day",
      "workingHours": "Mon-Fri 7AM-6PM",
      "emergencyService": true,
      "warranty": "Report accuracy guarantee",
      "icon": Icons.science
    },
    {
      "id": "SRV005",
      "name": "Pest Control & Management",
      "category": "Protection",
      "provider": "BioGuard Agricultural",
      "rating": 4.5,
      "totalBookings": 198,
      "price": 120.00,
      "duration": "2-4 hours",
      "location": "Field Treatment",
      "availability": "Available",
      "description": "Integrated pest management using eco-friendly and effective treatment methods",
      "services": ["Pest Identification", "Treatment Application", "Monitoring Setup", "Follow-up Visits"],
      "certifications": ["Pest Control License", "Organic Certified"],
      "image": "https://picsum.photos/400/300?random=5&keyword=pest",
      "contact": "+1 555-0654",
      "responseTime": "Within 4 hours",
      "workingHours": "Mon-Sun 6AM-7PM",
      "emergencyService": true,
      "warranty": "14 days effectiveness",
      "icon": Icons.bug_report
    },
    {
      "id": "SRV006",
      "name": "Agricultural Consulting",
      "category": "Consulting",
      "provider": "Farm Advisors Pro",
      "rating": 4.8,
      "totalBookings": 145,
      "price": 200.00,
      "duration": "2-3 hours consultation",
      "location": "On-site or Remote",
      "availability": "Available",
      "description": "Expert agricultural consulting for crop planning, yield optimization, and farm management",
      "services": ["Crop Planning", "Yield Analysis", "Cost Optimization", "Technology Recommendations"],
      "certifications": ["Agricultural Degree", "Certified Crop Advisor", "10+ Years Experience"],
      "image": "https://picsum.photos/400/300?random=6&keyword=consulting",
      "contact": "+1 555-0987",
      "responseTime": "Within 1 hour",
      "workingHours": "Mon-Sat 8AM-6PM",
      "emergencyService": false,
      "warranty": "Satisfaction guarantee",
      "icon": Icons.lightbulb
    }
  ];

  List<Map<String, dynamic>> myBookings = [
    {
      "id": "BKG001",
      "serviceName": "Tractor Maintenance Service",
      "provider": "AgriTech Solutions",
      "bookingDate": "2025-06-20",
      "scheduledTime": "09:00",
      "status": "Confirmed",
      "price": 150.00,
      "location": "Main Farm - Workshop",
      "technician": "Mike Johnson",
      "technicianPhone": "+1 555-0123",
      "serviceType": "Routine Maintenance",
      "equipment": "John Deere 6155R",
      "estimatedDuration": "3 hours",
      "specialInstructions": "Please check hydraulic system pressure",
      "bookingId": "BKG-2025-001"
    },
    {
      "id": "BKG002",
      "serviceName": "Soil Testing & Analysis",
      "provider": "AgriLab Services",
      "bookingDate": "2025-06-18",
      "scheduledTime": "14:30",
      "status": "In Progress",
      "price": 75.00,
      "location": "Field A - North Section",
      "technician": "Sarah Wilson",
      "technicianPhone": "+1 555-0321",
      "serviceType": "Comprehensive Analysis",
      "equipment": "N/A",
      "estimatedDuration": "1 hour sampling",
      "specialInstructions": "Test for both pH and nutrient levels",
      "bookingId": "BKG-2025-002"
    },
    {
      "id": "BKG003",
      "serviceName": "Pest Control & Management",
      "provider": "BioGuard Agricultural",
      "bookingDate": "2025-06-25",
      "scheduledTime": "07:00",
      "status": "Scheduled",
      "price": 120.00,
      "location": "Field B - South Section",
      "technician": "Robert Davis",
      "technicianPhone": "+1 555-0654",
      "serviceType": "Organic Treatment",
      "equipment": "Sprayer",
      "estimatedDuration": "3 hours",
      "specialInstructions": "Focus on aphid control in corn rows",
      "bookingId": "BKG-2025-003"
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Harvesting", "value": "Harvesting"},
    {"label": "Installation", "value": "Installation"},
    {"label": "Testing", "value": "Testing"},
    {"label": "Protection", "value": "Protection"},
    {"label": "Consulting", "value": "Consulting"}
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All", "value": "All"},
    {"label": "On-site Service", "value": "On-site Service"},
    {"label": "Field Service", "value": "Field Service"},
    {"label": "Field Installation", "value": "Field Installation"},
    {"label": "Field + Lab", "value": "Field + Lab"},
    {"label": "Field Treatment", "value": "Field Treatment"},
    {"label": "On-site or Remote", "value": "On-site or Remote"}
  ];

  List<Map<String, dynamic>> get filteredServices {
    return services.where((service) {
      bool matchesSearch = service["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                        service["provider"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || service["category"] == selectedCategory;
      bool matchesLocation = selectedLocation == "All" || service["location"] == selectedLocation;
      return matchesSearch && matchesCategory && matchesLocation;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Service Booking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.search)),
        Tab(text: "My Bookings", icon: Icon(Icons.book_online)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildMyBookingsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildServiceStats(),
          _buildServicesList(),
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
                label: "Search services...",
                value: searchQuery,
                hint: "Search by name or provider",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              size: bs.sm,
              onPressed: () {
                showFilters = !showFilters;
                setState(() {});
              },
            ),
          ],
        ),
        if (showFilters) ...[
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Location Type",
                  items: locationOptions,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildServiceStats() {
    int totalServices = services.length;
    int availableServices = services.where((s) => s["availability"] == "Available").length;
    double avgRating = services.fold(0.0, (sum, s) => sum + (s["rating"] as double)) / totalServices;
    int totalBookings = services.fold(0, (sum, s) => sum + (s["totalBookings"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Services", totalServices.toString(), Icons.room_service, primaryColor),
        _buildStatCard("Available", availableServices.toString(), Icons.check_circle, successColor),
        _buildStatCard("Avg Rating", "${avgRating.toStringAsFixed(1)}/5", Icons.star, warningColor),
        _buildStatCard("Total Bookings", "${(totalBookings / 1000).toStringAsFixed(1)}K", Icons.book, infoColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
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

  Widget _buildServicesList() {
    return Column(
      spacing: spSm,
      children: filteredServices.map((service) => _buildServiceCard(service)).toList(),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    Color availabilityColor = service["availability"] == "Available" ? successColor : warningColor;
    bool isAvailable = service["availability"] == "Available";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: availabilityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${service["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${service["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${service["provider"]} • ${service["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) => Icon(
                            index < (service["rating"] as double).floor() ? Icons.star : Icons.star_border,
                            color: warningColor,
                            size: 14,
                          )),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${service["rating"]} (${service["totalBookings"]})",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: availabilityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${service["availability"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: availabilityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${service["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildInfoItem("Price", "\$${(service["price"] as double).currency}", Icons.monetization_on),
              _buildInfoItem("Duration", "${service["duration"]}", Icons.access_time),
              _buildInfoItem("Location", "${service["location"]}", Icons.location_on),
              _buildInfoItem("Response", "${service["responseTime"]}", Icons.schedule),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Services Included:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (service["services"] as List).map((item) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Text(
                      "$item",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.verified, color: successColor, size: 16),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${(service["certifications"] as List).join(" • ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (service["emergencyService"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Emergency Service",
                    style: TextStyle(
                      fontSize: 10,
                      color: dangerColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          if (!isAvailable && service["nextAvailable"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: warningColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Next available: ${DateTime.parse("${service["nextAvailable"]}").dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isAvailable ? "Book Now" : "View Details",
                  size: bs.sm,
                  onPressed: () {
                    if (isAvailable) {
                      ss("Booking ${service["name"]}");
                    } else {
                      si("Viewing details for ${service["name"]}");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  si("Calling ${service["provider"]}");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  si("More info about ${service["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
        ),
      ],
    );
  }

  Widget _buildMyBookingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBookingStats(),
          _buildBookingsList(),
        ],
      ),
    );
  }

  Widget _buildBookingStats() {
    int totalBookings = myBookings.length;
    int confirmedBookings = myBookings.where((b) => b["status"] == "Confirmed").length;
    int inProgressBookings = myBookings.where((b) => b["status"] == "In Progress").length;
    double totalSpent = myBookings.fold(0.0, (sum, b) => sum + (b["price"] as double));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildBookingStatCard("Total Bookings", totalBookings.toString(), Icons.book_online, primaryColor),
        _buildBookingStatCard("Confirmed", confirmedBookings.toString(), Icons.check_circle, successColor),
        _buildBookingStatCard("In Progress", inProgressBookings.toString(), Icons.pending, warningColor),
        _buildBookingStatCard("Total Spent", "\$${totalSpent.currency}", Icons.monetization_on, infoColor),
      ],
    );
  }

  Widget _buildBookingStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildBookingsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "My Service Bookings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...myBookings.map((booking) => _buildBookingCard(booking)).toList(),
      ],
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor = _getStatusColor(booking["status"]);
    DateTime bookingDate = DateTime.parse("${booking["bookingDate"]}");
    TimeOfDay scheduledTime = "${booking["scheduledTime"]}".timeOfDay;

    return Container(
      padding: EdgeInsets.all(spMd),
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
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${booking["serviceName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${booking["provider"]} • ${booking["bookingId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${booking["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, color: statusColor, size: 16),
                SizedBox(width: spSm),
                Text(
                  "Scheduled: ${bookingDate.dMMMy} at ${scheduledTime.kkmm}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildBookingInfoItem("Price", "\$${(booking["price"] as double).currency}", Icons.monetization_on),
              _buildBookingInfoItem("Duration", "${booking["estimatedDuration"]}", Icons.timer),
              _buildBookingInfoItem("Location", "${booking["location"]}", Icons.location_on),
              _buildBookingInfoItem("Technician", "${booking["technician"]}", Icons.person),
            ],
          ),
          if (booking["equipment"] != "N/A")
            Row(
              children: [
                Icon(Icons.agriculture, color: primaryColor, size: 16),
                SizedBox(width: spSm),
                Text(
                  "Equipment: ${booking["equipment"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (booking["specialInstructions"] != null && (booking["specialInstructions"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.note, color: primaryColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Special Instructions: ${booking["specialInstructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: booking["status"] == "Scheduled" ? "Modify Booking" : "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("${booking["status"] == "Scheduled" ? "Modifying" : "Viewing"} booking ${booking["bookingId"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  si("Calling technician ${booking["technician"]}");
                },
              ),
              if (booking["status"] == "Scheduled") ...[
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.cancel,
                  size: bs.sm,
                  onPressed: () {
                    sw("Cancelling booking ${booking["bookingId"]}");
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    final completedBookings = [
      {
        "serviceName": "Crop Harvesting Service",
        "provider": "Harvest Masters",
        "bookingDate": "2025-05-15",
        "completedDate": "2025-05-15",
        "price": 680.00,
        "rating": 5,
        "review": "Excellent service, very professional team and efficient harvesting",
        "technician": "Mark Thompson",
        "duration": "8 hours"
      },
      {
        "serviceName": "Pest Control & Management",
        "provider": "BioGuard Agricultural",
        "bookingDate": "2025-04-20",
        "completedDate": "2025-04-20",
        "price": 120.00,
        "rating": 4,
        "review": "Good service, pest problem resolved effectively",
        "technician": "Lisa Garcia",
        "duration": "3 hours"
      },
      {
        "serviceName": "Agricultural Consulting",
        "provider": "Farm Advisors Pro",
        "bookingDate": "2025-03-10",
        "completedDate": "2025-03-10",
        "price": 200.00,
        "rating": 5,
        "review": "Very knowledgeable consultant, excellent recommendations for our crop planning",
        "technician": "Dr. James Wilson",
        "duration": "2.5 hours"
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryStats(completedBookings),
          _buildCompletedBookingsList(completedBookings),
        ],
      ),
    );
  }

  Widget _buildHistoryStats(List<Map<String, dynamic>> completedBookings) {
    int totalCompleted = completedBookings.length;
    double totalSpent = completedBookings.fold(0.0, (sum, b) => sum + (b["price"] as double));
    double avgRating = completedBookings.fold(0.0, (sum, b) => sum + (b["rating"] as int)) / totalCompleted;
    double totalHours = completedBookings.fold(0.0, (sum, b) => sum + double.parse("${b["duration"]}".split(" ")[0]));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildHistoryStatCard("Completed", totalCompleted.toString(), Icons.check_circle, successColor),
        _buildHistoryStatCard("Total Spent", "\$${(totalSpent / 1000).toStringAsFixed(1)}K", Icons.monetization_on, primaryColor),
        _buildHistoryStatCard("Avg Rating", "${avgRating.toStringAsFixed(1)}/5", Icons.star, warningColor),
        _buildHistoryStatCard("Service Hours", "${totalHours.toStringAsFixed(1)}h", Icons.timer, infoColor),
      ],
    );
  }

  Widget _buildHistoryStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildCompletedBookingsList(List<Map<String, dynamic>> completedBookings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Service History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...completedBookings.map((booking) => _buildCompletedBookingCard(booking)).toList(),
      ],
    );
  }

  Widget _buildCompletedBookingCard(Map<String, dynamic> booking) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: successColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${booking["serviceName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${booking["provider"]} • ${booking["technician"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) => Icon(
                  index < (booking["rating"] as int) ? Icons.star : Icons.star_border,
                  color: warningColor,
                  size: 16,
                )),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildHistoryInfoItem("Service Date", "${DateTime.parse("${booking["bookingDate"]}").dMMMy}", Icons.event),
              _buildHistoryInfoItem("Duration", "${booking["duration"]}", Icons.timer),
              _buildHistoryInfoItem("Cost", "\$${(booking["price"] as double).currency}", Icons.monetization_on),
              _buildHistoryInfoItem("Completed", "${DateTime.parse("${booking["completedDate"]}").dMMMy}", Icons.check),
            ],
          ),
          if (booking["review"] != null && (booking["review"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.rate_review, color: successColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${booking["review"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Book Again",
                  size: bs.sm,
                  onPressed: () {
                    ss("Booking ${booking["serviceName"]} again");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.receipt,
                size: bs.sm,
                onPressed: () {
                  si("Downloading service receipt");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: successColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Scheduled":
        return infoColor;
      case "Completed":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
