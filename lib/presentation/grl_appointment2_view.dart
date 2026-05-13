import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAppointment2View extends StatefulWidget {
  @override
  State<GrlAppointment2View> createState() => _GrlAppointment2ViewState();
}

class _GrlAppointment2ViewState extends State<GrlAppointment2View> {
  String selectedDate = DateTime.now().toString();
  String selectedDoctor = "";
  String selectedTimeSlot = "";
  
  List<Map<String, dynamic>> doctors = [
    {
      "id": "DOC001",
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiology",
      "rating": 4.8,
      "experience": "15 years",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=doctor",
      "consultationFee": 120.0,
      "availableSlots": ["09:00", "10:00", "11:00", "14:00", "15:00"],
      "nextAvailable": "Today",
    },
    {
      "id": "DOC002",
      "name": "Dr. Michael Chen",
      "specialty": "Dermatology",
      "rating": 4.9,
      "experience": "12 years",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=doctor",
      "consultationFee": 100.0,
      "availableSlots": ["08:30", "09:30", "13:00", "16:00"],
      "nextAvailable": "Tomorrow",
    },
    {
      "id": "DOC003",
      "name": "Dr. Emily Rodriguez",
      "specialty": "Pediatrics",
      "rating": 4.7,
      "experience": "18 years",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=doctor",
      "consultationFee": 90.0,
      "availableSlots": ["10:00", "11:30", "14:30", "15:30"],
      "nextAvailable": "Today",
    },
    {
      "id": "DOC004",
      "name": "Dr. James Wilson",
      "specialty": "Orthopedics",
      "rating": 4.6,
      "experience": "20 years",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=doctor",
      "consultationFee": 150.0,
      "availableSlots": ["09:00", "13:00", "16:30"],
      "nextAvailable": "Tomorrow",
    },
  ];

  List<String> specialties = [
    "All Specialties",
    "Cardiology", 
    "Dermatology",
    "Pediatrics",
    "Orthopedics",
    "Neurology",
    "General Medicine"
  ];

  String selectedSpecialty = "All Specialties";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildDateSelection(),
            _buildSpecialtyFilter(),
            _buildDoctorsList(),
            if (selectedDoctor.isNotEmpty) ...[
              _buildTimeSlotSelection(),
              _buildBookingConfirmation(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Select Appointment Date",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Preferred Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString();
              selectedTimeSlot = ""; // Reset time slot when date changes
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Filter by Specialty",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QCategoryPicker(
            items: specialties.map((specialty) => {
              "label": specialty,
              "value": specialty,
            }).toList(),
            value: selectedSpecialty,
            onChanged: (index, label, value, item) {
              selectedSpecialty = value;
              selectedDoctor = ""; // Reset doctor selection
              selectedTimeSlot = ""; // Reset time slot
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList() {
    List<Map<String, dynamic>> filteredDoctors = doctors;
    
    if (selectedSpecialty != "All Specialties") {
      filteredDoctors = doctors.where(
        (doctor) => doctor["specialty"] == selectedSpecialty
      ).toList();
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_search,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Available Doctors",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          if (filteredDoctors.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              child: Center(
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    Text(
                      "No doctors available",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try selecting a different specialty",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            ...filteredDoctors.map((doctor) {
              final isSelected = selectedDoctor == doctor["id"];
              return GestureDetector(
                onTap: () {
                  selectedDoctor = doctor["id"];
                  selectedTimeSlot = ""; // Reset time slot selection
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${doctor["avatar"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${doctor["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                            Text(
                              "${doctor["specialty"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${doctor["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "• ${doctor["experience"]} experience",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Next: ${doctor["nextAvailable"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${(doctor["consultationFee"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeSlotSelection() {
    final selectedDoctorData = doctors.firstWhere(
      (doctor) => doctor["id"] == selectedDoctor,
    );
    
    List<String> availableSlots = selectedDoctorData["availableSlots"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Select Time Slot",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Available slots for ${selectedDoctorData["name"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: availableSlots.map((slot) {
              final isSelected = selectedTimeSlot == slot;
              return GestureDetector(
                onTap: () {
                  selectedTimeSlot = slot;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    slot,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : disabledBoldColor,
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

  Widget _buildBookingConfirmation() {
    if (selectedTimeSlot.isEmpty) return Container();
    
    final selectedDoctorData = doctors.firstWhere(
      (doctor) => doctor["id"] == selectedDoctor,
    );
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_available,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Appointment Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${selectedDoctorData["avatar"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${selectedDoctorData["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${selectedDoctorData["specialty"]}",
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
                Divider(color: Colors.grey[300]),
                _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
                _buildSummaryRow("Time", selectedTimeSlot),
                _buildSummaryRow("Duration", "30 minutes"),
                _buildSummaryRow("Consultation Fee", "\$${(selectedDoctorData["consultationFee"] as double).toStringAsFixed(2)}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Please arrive 15 minutes before your appointment time",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Confirm Appointment",
              size: bs.md,
              onPressed: () {
                _confirmAppointment();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _confirmAppointment() {
    final selectedDoctorData = doctors.firstWhere(
      (doctor) => doctor["id"] == selectedDoctor,
    );
    
    ss("Appointment booked with ${selectedDoctorData["name"]} on ${DateTime.parse(selectedDate).dMMMy} at $selectedTimeSlot");
  }
}
