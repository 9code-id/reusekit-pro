import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSpaBookingView extends StatefulWidget {
  const HhaSpaBookingView({super.key});

  @override
  State<HhaSpaBookingView> createState() => _HhaSpaBookingViewState();
}

class _HhaSpaBookingViewState extends State<HhaSpaBookingView> {
  int selectedTab = 0;
  
  // Form fields
  String selectedService = "";
  String selectedTherapist = "";
  String selectedDate = DateTime.now().toString();
  String selectedTime = "10:00";
  String selectedDuration = "60";
  int numberOfGuests = 1;
  String specialRequests = "";
  String contactNumber = "";
  String roomNumber = "";
  
  // Filter fields
  String filterCategory = "";
  String filterTherapist = "";
  String priceRange = "all";
  
  // Booking history filters
  String historyFilter = "upcoming";
  String searchBooking = "";

  List<Map<String, dynamic>> spaServices = [
    {
      "id": "spa001",
      "name": "Swedish Massage",
      "category": "Massage",
      "description": "Relaxing full-body massage with gentle strokes",
      "duration": 60,
      "price": 120.0,
      "rating": 4.8,
      "image": "https://picsum.photos/400/300?random=1&keyword=spa",
      "therapists": ["Sarah Johnson", "Maria Rodriguez", "Thai Nguyen"],
      "benefits": ["Stress relief", "Muscle relaxation", "Improved circulation"]
    },
    {
      "id": "spa002", 
      "name": "Deep Tissue Massage",
      "category": "Massage",
      "description": "Therapeutic massage targeting muscle knots and tension",
      "duration": 90,
      "price": 150.0,
      "rating": 4.9,
      "image": "https://picsum.photos/400/300?random=2&keyword=massage",
      "therapists": ["David Chen", "Lisa Thompson"],
      "benefits": ["Pain relief", "Muscle recovery", "Improved flexibility"]
    },
    {
      "id": "spa003",
      "name": "Hot Stone Therapy",
      "category": "Massage",
      "description": "Heated stones placed on body to relieve tension",
      "duration": 75,
      "price": 140.0,
      "rating": 4.7,
      "image": "https://picsum.photos/400/300?random=3&keyword=stones",
      "therapists": ["Elena Volkov", "James Wilson"],
      "benefits": ["Deep relaxation", "Stress reduction", "Improved sleep"]
    },
    {
      "id": "spa004",
      "name": "Aromatherapy Facial",
      "category": "Facial",
      "description": "Rejuvenating facial with essential oils",
      "duration": 60,
      "price": 95.0,
      "rating": 4.6,
      "image": "https://picsum.photos/400/300?random=4&keyword=facial",
      "therapists": ["Anna Martinez", "Sophie Turner"],
      "benefits": ["Skin rejuvenation", "Hydration", "Anti-aging"]
    },
    {
      "id": "spa005",
      "name": "Body Wrap Treatment",
      "category": "Body Treatment",
      "description": "Detoxifying body wrap with marine algae",
      "duration": 90,
      "price": 110.0,
      "rating": 4.5,
      "image": "https://picsum.photos/400/300?random=5&keyword=wrap",
      "therapists": ["Carmen Lopez", "Michael Brown"],
      "benefits": ["Detoxification", "Skin tightening", "Hydration"]
    },
    {
      "id": "spa006",
      "name": "Couples Massage",
      "category": "Massage",
      "description": "Relaxing massage experience for two",
      "duration": 60,
      "price": 220.0,
      "rating": 4.9,
      "image": "https://picsum.photos/400/300?random=6&keyword=couples",
      "therapists": ["Multiple therapists available"],
      "benefits": ["Shared relaxation", "Bonding experience", "Romance"]
    }
  ];

  List<Map<String, dynamic>> bookingHistory = [
    {
      "id": "booking001",
      "service": "Swedish Massage",
      "therapist": "Sarah Johnson",
      "date": "2024-01-20",
      "time": "10:00",
      "duration": 60,
      "price": 120.0,
      "status": "upcoming",
      "room": "Serenity Suite",
      "guests": 1
    },
    {
      "id": "booking002",
      "service": "Couples Massage",
      "therapist": "Multiple",
      "date": "2024-01-15",
      "time": "14:00",
      "duration": 60,
      "price": 220.0,
      "status": "completed",
      "room": "Romance Suite",
      "guests": 2,
      "rating": 5
    },
    {
      "id": "booking003",
      "service": "Aromatherapy Facial",
      "therapist": "Anna Martinez",
      "date": "2024-01-10",
      "time": "11:00",
      "duration": 60,
      "price": 95.0,
      "status": "completed",
      "room": "Renewal Room",
      "guests": 1,
      "rating": 4
    },
    {
      "id": "booking004",
      "service": "Deep Tissue Massage",
      "therapist": "David Chen",
      "date": "2024-01-25",
      "time": "16:00",
      "duration": 90,
      "price": 150.0,
      "status": "upcoming",
      "room": "Therapy Room A",
      "guests": 1
    }
  ];

  List<Map<String, dynamic>> therapists = [
    {
      "id": "therapist001",
      "name": "Sarah Johnson",
      "specialties": ["Swedish Massage", "Aromatherapy"],
      "experience": "8 years",
      "rating": 4.9,
      "image": "https://picsum.photos/100/100?random=10&keyword=therapist",
      "bio": "Certified massage therapist specializing in relaxation techniques"
    },
    {
      "id": "therapist002",
      "name": "David Chen",
      "specialties": ["Deep Tissue", "Sports Massage"],
      "experience": "10 years",
      "rating": 4.8,
      "image": "https://picsum.photos/100/100?random=11&keyword=therapist",
      "bio": "Licensed therapist with expertise in therapeutic treatments"
    },
    {
      "id": "therapist003",
      "name": "Maria Rodriguez",
      "specialties": ["Hot Stone", "Prenatal Massage"],
      "experience": "6 years",
      "rating": 4.7,
      "image": "https://picsum.photos/100/100?random=12&keyword=therapist",
      "bio": "Holistic wellness practitioner focused on healing touch"
    }
  ];

  List<Map<String, dynamic>> timeSlots = [
    {"label": "9:00 AM", "value": "09:00", "available": true},
    {"label": "10:00 AM", "value": "10:00", "available": true},
    {"label": "11:00 AM", "value": "11:00", "available": false},
    {"label": "12:00 PM", "value": "12:00", "available": true},
    {"label": "1:00 PM", "value": "13:00", "available": true},
    {"label": "2:00 PM", "value": "14:00", "available": false},
    {"label": "3:00 PM", "value": "15:00", "available": true},
    {"label": "4:00 PM", "value": "16:00", "available": true},
    {"label": "5:00 PM", "value": "17:00", "available": true},
    {"label": "6:00 PM", "value": "18:00", "available": false}
  ];

  List<Map<String, dynamic>> get filteredServices {
    List<Map<String, dynamic>> filtered = spaServices;
    
    if (filterCategory.isNotEmpty) {
      filtered = filtered.where((service) => 
        service["category"] == filterCategory).toList();
    }
    
    if (filterTherapist.isNotEmpty) {
      filtered = filtered.where((service) => 
        (service["therapists"] as List).contains(filterTherapist)).toList();
    }
    
    if (priceRange != "all") {
      switch (priceRange) {
        case "under_100":
          filtered = filtered.where((service) => 
            (service["price"] as double) < 100).toList();
          break;
        case "100_150":
          filtered = filtered.where((service) => 
            (service["price"] as double) >= 100 && 
            (service["price"] as double) <= 150).toList();
          break;
        case "over_150":
          filtered = filtered.where((service) => 
            (service["price"] as double) > 150).toList();
          break;
      }
    }
    
    return filtered;
  }

  List<Map<String, dynamic>> get filteredBookings {
    List<Map<String, dynamic>> filtered = bookingHistory;
    
    if (historyFilter != "all") {
      filtered = filtered.where((booking) => 
        booking["status"] == historyFilter).toList();
    }
    
    if (searchBooking.isNotEmpty) {
      filtered = filtered.where((booking) =>
        booking["service"].toString().toLowerCase().contains(searchBooking.toLowerCase()) ||
        booking["therapist"].toString().toLowerCase().contains(searchBooking.toLowerCase())).toList();
    }
    
    return filtered;
  }

  void _bookService(Map<String, dynamic> service) {
    selectedService = service["name"];
    selectedTab = 1; // Switch to booking tab
    setState(() {});
  }

  void _submitBooking() async {
    if (selectedService.isEmpty || selectedDate.isEmpty || selectedTime.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Spa booking confirmed successfully!");
    // navigateTo(HhaBookingConfirmationView());
  }

  void _cancelBooking(String bookingId) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this booking?");
    if (!isConfirmed) return;

    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("Booking cancelled successfully");
    setState(() {});
  }

  void _rescheduleBooking(Map<String, dynamic> booking) {
    selectedService = booking["service"];
    selectedTherapist = booking["therapist"];
    selectedTab = 1; // Switch to booking tab
    setState(() {});
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.spa,
                    color: primaryColor,
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Spa Services",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Relax and rejuvenate with our premium spa treatments",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Filters
          Text(
            "Filter Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: [
                    {"label": "All Categories", "value": ""},
                    {"label": "Massage", "value": "Massage"},
                    {"label": "Facial", "value": "Facial"},
                    {"label": "Body Treatment", "value": "Body Treatment"}
                  ],
                  value: filterCategory,
                  onChanged: (value, label) {
                    filterCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Price Range",
                  items: [
                    {"label": "All Prices", "value": "all"},
                    {"label": "Under \$100", "value": "under_100"},
                    {"label": "\$100 - \$150", "value": "100_150"},
                    {"label": "Over \$150", "value": "over_150"}
                  ],
                  value: priceRange,
                  onChanged: (value, label) {
                    priceRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Services Grid
          Text(
            "Available Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.all(spXs),
            minItemWidth: 200,
            children: filteredServices.map((service) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Image
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        child: Image.network(
                          "${service["image"]}",
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    // Service Info
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${service["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${service["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${service["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.access_time,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${service["duration"]} min",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${service["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Benefits
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (service["benefits"] as List).map((benefit) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$benefit",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Price and Book Button
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Starting from",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(service["price"] as double).toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "Book Now",
                                size: bs.sm,
                                onPressed: () => _bookService(service),
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
        ],
      ),
    );
  }

  Widget _buildBookingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Book Spa Service",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Fill in the details below to book your spa treatment",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Service Selection
          Text(
            "Service Selection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Select Service",
            items: spaServices.map((service) => {
              "label": "${service["name"]} - \$${(service["price"] as double).toStringAsFixed(0)} (${service["duration"]} min)",
              "value": service["name"]
            }).toList(),
            value: selectedService,
            onChanged: (value, label) {
              selectedService = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          if (selectedService.isNotEmpty) ...[
            // Service Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Service Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.spa, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text("Service: $selectedService"),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text("Duration: ${spaServices.firstWhere((s) => s["name"] == selectedService)["duration"]} minutes"),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text("Price: \$${(spaServices.firstWhere((s) => s["name"] == selectedService)["price"] as double).toStringAsFixed(0)}"),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
          ],
          
          // Therapist Selection
          Text(
            "Therapist Selection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Preferred Therapist",
            items: [
              {"label": "Any Available Therapist", "value": ""},
              ...therapists.map((therapist) => {
                "label": "${therapist["name"]} - ${therapist["specialties"].join(", ")}",
                "value": therapist["name"]
              })
            ],
            value: selectedTherapist,
            onChanged: (value, label) {
              selectedTherapist = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Date and Time
          Text(
            "Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTimePicker(
                  label: "Time",
                  value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $selectedTime:00")),
                  onChanged: (value) {
                    if (value != null) {
                      selectedTime = value.kkmm;
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Available Time Slots
          Text(
            "Available Time Slots",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spXs),
          
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: timeSlots.map((slot) {
              bool isSelected = selectedTime == slot["value"];
              bool isAvailable = slot["available"];
              
              return GestureDetector(
                onTap: isAvailable ? () {
                  selectedTime = slot["value"];
                  setState(() {});
                } : null,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primaryColor 
                        : isAvailable 
                            ? Colors.white 
                            : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected 
                          ? primaryColor 
                          : isAvailable 
                              ? primaryColor.withAlpha(50)
                              : disabledBoldColor,
                    ),
                  ),
                  child: Text(
                    "${slot["label"]}",
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white 
                          : isAvailable 
                              ? primaryColor 
                              : disabledBoldColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Guest Details
          Text(
            "Guest Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Contact Number",
                  value: contactNumber,
                  hint: "Enter your phone number",
                  onChanged: (value) {
                    contactNumber = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Room Number",
                  value: roomNumber,
                  hint: "Room #",
                  onChanged: (value) {
                    roomNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Number of Guests",
                  value: numberOfGuests.toString(),
                  onChanged: (value) {
                    numberOfGuests = int.tryParse(value) ?? 1;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Duration",
                  items: [
                    {"label": "60 minutes", "value": "60"},
                    {"label": "90 minutes", "value": "90"},
                    {"label": "120 minutes", "value": "120"}
                  ],
                  value: selectedDuration,
                  onChanged: (value, label) {
                    selectedDuration = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Special Requests",
            value: specialRequests,
            hint: "Any special requirements or health conditions we should know about?",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Booking Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: secondaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: secondaryColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt, color: secondaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "Booking Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Service:"),
                    Text(
                      selectedService.isEmpty ? "Not selected" : selectedService,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date:"),
                    Text(
                      DateTime.parse(selectedDate).dMMMy,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time:"),
                    Text(
                      selectedTime,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Guests:"),
                    Text(
                      "$numberOfGuests",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Divider(),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      selectedService.isNotEmpty 
                          ? "\$${((spaServices.firstWhere((s) => s["name"] == selectedService)["price"] as double) * numberOfGuests).toStringAsFixed(0)}"
                          : "\$0",
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
          
          SizedBox(height: spMd),
          
          // Book Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Confirm Booking",
              size: bs.md,
              onPressed: _submitBooking,
            ),
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
        children: [
          // Header
          Text(
            "Booking History",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "View and manage your spa bookings",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Bookings",
                  value: searchBooking,
                  hint: "Search by service or therapist",
                  onChanged: (value) {
                    searchBooking = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: [
                    {"label": "All Bookings", "value": "all"},
                    {"label": "Upcoming", "value": "upcoming"},
                    {"label": "Completed", "value": "completed"},
                    {"label": "Cancelled", "value": "cancelled"}
                  ],
                  value: historyFilter,
                  onChanged: (value, label) {
                    historyFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Bookings List
          if (filteredBookings.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.spa_outlined,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No bookings found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Book your first spa service to see it here",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Column(
              spacing: spSm,
              children: filteredBookings.map((booking) {
                Color statusColor = booking["status"] == "upcoming" 
                    ? infoColor 
                    : booking["status"] == "completed" 
                        ? successColor 
                        : dangerColor;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${booking["service"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "with ${booking["therapist"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${booking["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Details
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            DateTime.parse(booking["date"]).dMMMy,
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${booking["time"]}",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.person, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${booking["guests"]} guest${(booking["guests"] as int) > 1 ? 's' : ''}",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Row(
                        children: [
                          Icon(Icons.room, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${booking["room"]}",
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${booking["duration"]} min",
                            style: TextStyle(fontSize: 13),
                          ),
                          Spacer(),
                          Text(
                            "\$${(booking["price"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      
                      if (booking["status"] == "completed" && booking.containsKey("rating")) ...[
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Text(
                              "Your rating: ",
                              style: TextStyle(fontSize: 13),
                            ),
                            ...List.generate(5, (index) {
                              return Icon(
                                index < (booking["rating"] as int) 
                                    ? Icons.star 
                                    : Icons.star_border,
                                color: warningColor,
                                size: 16,
                              );
                            }),
                          ],
                        ),
                      ],
                      
                      SizedBox(height: spSm),
                      
                      // Actions
                      Row(
                        children: [
                          if (booking["status"] == "upcoming") ...[
                            Expanded(
                              child: QButton(
                                label: "Reschedule",
                                size: bs.sm,
                                color: infoColor,
                                onPressed: () => _rescheduleBooking(booking),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Cancel",
                                size: bs.sm,
                                color: dangerColor,
                                onPressed: () => _cancelBooking(booking["id"]),
                              ),
                            ),
                          ],
                          if (booking["status"] == "completed") ...[
                            Expanded(
                              child: QButton(
                                label: "Book Again",
                                size: bs.sm,
                                onPressed: () => _bookService({
                                  "name": booking["service"],
                                  "price": booking["price"],
                                  "duration": booking["duration"]
                                }),
                              ),
                            ),
                            if (!booking.containsKey("rating")) ...[
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Rate Service",
                                  size: bs.sm,
                                  color: warningColor,
                                  onPressed: () {
                                    // navigateTo(RatingView());
                                  },
                                ),
                              ),
                            ]
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Spa Booking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Services", icon: Icon(Icons.spa)),
        Tab(text: "Book Now", icon: Icon(Icons.event_available)),
        Tab(text: "My Bookings", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildServicesTab(),
        _buildBookingTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
