import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAppointment5View extends StatefulWidget {
  @override
  State<GrlAppointment5View> createState() => _GrlAppointment5ViewState();
}

class _GrlAppointment5ViewState extends State<GrlAppointment5View> {
  String selectedService = "consultation";
  String selectedDoctor = "";
  String selectedDate = "";
  String selectedTime = "";
  String patientNotes = "";
  bool isUrgent = false;
  String paymentMethod = "insurance";

  List<Map<String, dynamic>> services = [
    {
      "label": "General Consultation",
      "value": "consultation",
      "duration": "30 min",
      "price": 80.0,
      "icon": Icons.medical_services,
    },
    {
      "label": "Health Check-up",
      "value": "checkup",
      "duration": "60 min",
      "price": 120.0,
      "icon": Icons.health_and_safety,
    },
    {
      "label": "Vaccination",
      "value": "vaccination",
      "duration": "15 min",
      "price": 40.0,
      "icon": Icons.vaccines,
    },
    {
      "label": "Blood Test",
      "value": "blood_test",
      "duration": "20 min",
      "price": 60.0,
      "icon": Icons.bloodtype,
    },
  ];

  List<Map<String, dynamic>> doctors = [
    {
      "label": "Dr. Sarah Johnson - Cardiologist",
      "value": "dr_sarah",
      "specialty": "Cardiology",
      "rating": 4.8,
      "image": "https://picsum.photos/50/50?random=1&keyword=doctor",
    },
    {
      "label": "Dr. Michael Chen - Dermatologist",
      "value": "dr_michael",
      "specialty": "Dermatology",
      "rating": 4.9,
      "image": "https://picsum.photos/50/50?random=2&keyword=doctor",
    },
    {
      "label": "Dr. Emily Davis - Pediatrician",
      "value": "dr_emily",
      "specialty": "Pediatrics",
      "rating": 4.7,
      "image": "https://picsum.photos/50/50?random=3&keyword=doctor",
    },
  ];

  List<String> timeSlots = [
    "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
    "14:00", "14:30", "15:00", "15:30", "16:00", "16:30",
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "label": "Health Insurance",
      "value": "insurance",
    },
    {
      "label": "Credit Card",
      "value": "credit_card",
    },
    {
      "label": "Cash Payment",
      "value": "cash",
    },
  ];

  Map<String, dynamic> get selectedServiceData {
    return services.firstWhere(
      (service) => service["value"] == selectedService,
      orElse: () => services[0],
    );
  }

  void _bookAppointment() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Appointment booked successfully!");
    
    // Reset form
    setState(() {
      selectedService = "consultation";
      selectedDoctor = "";
      selectedDate = "";
      selectedTime = "";
      patientNotes = "";
      isUrgent = false;
      paymentMethod = "insurance";
    });
  }

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
          children: [
            // Service Selection
            Text(
              "Select Service",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: services.map((service) => {
                "label": "${service["label"]}",
                "value": "${service["value"]}",
              }).toList(),
              value: selectedService,
              onChanged: (index, label, value, item) {
                selectedService = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Selected Service Details
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    selectedServiceData["icon"] as IconData,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedServiceData["label"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${selectedServiceData["duration"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Text(
                              "\$${((selectedServiceData["price"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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

            SizedBox(height: spLg),

            // Doctor Selection
            QDropdownField(
              label: "Select Doctor",
              items: doctors,
              value: selectedDoctor,
              onChanged: (value, label) {
                selectedDoctor = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Date Selection
            QDatePicker(
              label: "Appointment Date",
              value: selectedDate.isNotEmpty ? DateTime.parse(selectedDate) : DateTime.now(),
              onChanged: (value) {
                selectedDate = value.toString().split(' ')[0];
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Time Selection
            Text(
              "Available Time Slots",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: timeSlots.map((time) {
                bool isSelected = selectedTime == time;
                return GestureDetector(
                  onTap: () {
                    selectedTime = time;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 1,
                      ),
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

            SizedBox(height: spLg),

            // Priority Toggle
            QSwitch(
              items: [
                {
                  "label": "Mark as Urgent",
                  "value": true,
                  "checked": isUrgent,
                }
              ],
              value: [
                if (isUrgent)
                  {
                    "label": "Mark as Urgent",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  isUrgent = values.isNotEmpty;
                });
              },
            ),

            if (isUrgent) ...[
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: warningColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.priority_high,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Urgent appointments may incur additional fees and will be prioritized.",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spMd),

            // Patient Notes
            QMemoField(
              label: "Additional Notes",
              value: patientNotes,
              hint: "Describe your symptoms or concerns",
              onChanged: (value) {
                patientNotes = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Payment Method
            QDropdownField(
              label: "Payment Method",
              items: paymentMethods,
              value: paymentMethod,
              onChanged: (value, label) {
                paymentMethod = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Summary Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Appointment Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  if (selectedDoctor.isNotEmpty) ...[
                    _buildSummaryRow("Doctor", doctors.firstWhere((d) => d["value"] == selectedDoctor)["label"]),
                    SizedBox(height: spSm),
                  ],

                  _buildSummaryRow("Service", "${selectedServiceData["label"]}"),
                  SizedBox(height: spSm),

                  if (selectedDate.isNotEmpty) ...[
                    _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
                    SizedBox(height: spSm),
                  ],

                  if (selectedTime.isNotEmpty) ...[
                    _buildSummaryRow("Time", selectedTime),
                    SizedBox(height: spSm),
                  ],

                  _buildSummaryRow("Duration", "${selectedServiceData["duration"]}"),
                  SizedBox(height: spSm),

                  if (isUrgent) ...[
                    _buildSummaryRow("Priority", "Urgent", color: warningColor),
                    SizedBox(height: spSm),
                  ],

                  Divider(),
                  SizedBox(height: spSm),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Fee",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${((selectedServiceData["price"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Book Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Book Appointment",
                size: bs.md,
                onPressed: selectedDoctor.isNotEmpty && selectedDate.isNotEmpty && selectedTime.isNotEmpty
                    ? _bookAppointment
                    : null,
              ),
            ),

            SizedBox(height: spMd),

            // Terms and Conditions
            Text(
              "By booking this appointment, you agree to our terms and conditions. You will receive a confirmation email shortly.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color ?? primaryColor,
          ),
        ),
      ],
    );
  }
}
