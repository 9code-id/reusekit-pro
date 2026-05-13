import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaSessionBookingView extends StatefulWidget {
  const FwaSessionBookingView({super.key});

  @override
  State<FwaSessionBookingView> createState() => _FwaSessionBookingViewState();
}

class _FwaSessionBookingViewState extends State<FwaSessionBookingView> {
  Map<String, dynamic> trainer = {
    "id": "trainer_1",
    "name": "Sarah Johnson",
    "title": "Certified Personal Trainer",
    "avatar": "https://picsum.photos/150/150?random=60&keyword=trainer",
    "rating": 4.9,
    "reviewCount": 156,
    "price": 85,
    "location": "Downtown Gym",
    "specialties": ["Weight Loss", "Strength Training", "Nutrition"],
  };

  String selectedDate = DateTime.now().toString().split(' ')[0];
  String selectedTime = "";
  String selectedPackage = "single";
  String sessionType = "Strength Training";
  String sessionGoal = "";
  String fitnessLevel = "Intermediate";
  String specialRequests = "";

  List<Map<String, dynamic>> packages = [
    {
      "id": "single",
      "name": "Single Session",
      "price": 85,
      "sessions": 1,
      "description": "Perfect for trying out my training style",
    },
    {
      "id": "weekly",
      "name": "Weekly Package",
      "price": 300,
      "sessions": 4,
      "description": "Most popular choice for consistent progress",
      "savings": 40,
    },
    {
      "id": "monthly",
      "name": "Monthly Transformation",
      "price": 1000,
      "sessions": 16,
      "description": "Complete lifestyle transformation program",
      "savings": 360,
    },
  ];

  List<String> availableTimes = [
    "06:00", "07:00", "08:00", "09:00", "10:00",
    "17:00", "18:00", "19:00", "20:00"
  ];

  List<String> sessionTypes = [
    "Strength Training",
    "Cardio Workout",
    "HIIT Training",
    "Functional Training",
    "Weight Loss Focus",
    "Muscle Building",
    "Flexibility & Mobility",
    "Sports Specific"
  ];

  List<String> fitnessLevels = [
    "Beginner",
    "Intermediate",
    "Advanced"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Session"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showBookingHelp();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTrainerInfo(),
            SizedBox(height: spMd),
            _buildPackageSelection(),
            SizedBox(height: spMd),
            _buildDateTimeSelection(),
            SizedBox(height: spMd),
            _buildSessionConfiguration(),
            SizedBox(height: spMd),
            _buildBookingSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBookingActions(),
    );
  }

  Widget _buildTrainerInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [shadowSm],
            ),
            child: ClipOval(
              child: Image.network(
                "${trainer["avatar"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trainer["name"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${trainer["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: warningColor, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "${trainer["rating"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${trainer["reviewCount"]} reviews",
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
              Text(
                "\$${trainer["price"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "per session",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPackageSelection() {
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
            "Select Package",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: packages.map((package) {
              bool isSelected = selectedPackage == package["id"];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPackage = package["id"];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(25) : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                              width: 2,
                            ),
                            color: isSelected ? primaryColor : Colors.transparent,
                          ),
                          child: isSelected
                              ? Icon(Icons.check, color: Colors.white, size: 12)
                              : null,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${package["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  if (package["savings"] != null) ...[
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "SAVE \$${package["savings"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${package["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Text(
                                    "\$${package["price"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${package["sessions"]} session${(package["sessions"] as int) > 1 ? "s" : ""}",
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
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelection() {
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
            "Select Date & Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDatePicker(
            label: "Session Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Text(
            "Available Times",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: availableTimes.map((time) {
              bool isSelected = selectedTime == time;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTime = time;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionConfiguration() {
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
            "Session Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Session Type",
            value: sessionType,
            items: sessionTypes.map((type) => {
              "label": type,
              "value": type,
            }).toList(),
            onChanged: (value, label) {
              setState(() {
                sessionType = value;
              });
            },
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Fitness Level",
            value: fitnessLevel,
            items: fitnessLevels.map((level) => {
              "label": level,
              "value": level,
            }).toList(),
            onChanged: (value, label) {
              setState(() {
                fitnessLevel = value;
              });
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Session Goal",
            value: sessionGoal,
            hint: "What do you want to achieve in this session?",
            onChanged: (value) {
              sessionGoal = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Special Requests or Notes",
            value: specialRequests,
            hint: "Any injuries, preferences, or special requirements?",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    Map<String, dynamic> selectedPkg = packages.firstWhere((pkg) => pkg["id"] == selectedPackage);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Trainer", "${trainer["name"]}"),
          _buildSummaryRow("Package", "${selectedPkg["name"]}"),
          _buildSummaryRow("Sessions", "${selectedPkg["sessions"]}"),
          if (selectedDate.isNotEmpty && selectedTime.isNotEmpty)
            _buildSummaryRow("Date & Time", "${DateTime.parse(selectedDate).dMMMy} at $selectedTime"),
          _buildSummaryRow("Session Type", sessionType),
          _buildSummaryRow("Fitness Level", fitnessLevel),
          if (sessionGoal.isNotEmpty)
            _buildSummaryRow("Goal", sessionGoal),
          SizedBox(height: spMd),
          Divider(),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${selectedPkg["price"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  if (selectedPkg["savings"] != null)
                    Text(
                      "You save \$${selectedPkg["savings"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingActions() {
    bool canBook = selectedDate.isNotEmpty && 
                   selectedTime.isNotEmpty && 
                   sessionGoal.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.md,
                  onPressed: () {
                    _saveDraft();
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                flex: 2,
                child: QButton(
                  label: "Confirm Booking",
                  size: bs.md,
                  onPressed: canBook ? () {
                    _confirmBooking();
                  } : null,
                ),
              ),
            ],
          ),
          if (!canBook) ...[
            SizedBox(height: spSm),
            Text(
              "Please complete all required fields to continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: dangerColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showBookingHelp() {
    // Show booking help dialog
  }

  void _saveDraft() {
    // Save booking as draft
    ss("Booking saved as draft");
  }

  void _confirmBooking() {
    // Confirm booking
    ss("Session booked successfully!");
    back();
  }
}
