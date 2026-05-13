import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaAppointmentDetailView extends StatefulWidget {
  const MhaAppointmentDetailView({super.key});

  @override
  State<MhaAppointmentDetailView> createState() => _MhaAppointmentDetailViewState();
}

class _MhaAppointmentDetailViewState extends State<MhaAppointmentDetailView> {
  final Map<String, dynamic> appointment = {
    "id": "APT001",
    "status": "Completed",
    "createdDate": "2024-01-10",
    "doctor": {
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "qualification": "MD, FACC",
      "experience": "15 years",
      "image": "https://picsum.photos/300/300?random=1&keyword=doctor",
      "hospital": "City General Hospital",
      "rating": 4.8,
      "phone": "+1 555 0123",
      "email": "sarah.johnson@cityhospital.com",
    },
    "patient": {
      "name": "John Smith",
      "age": 35,
      "gender": "Male",
      "phone": "+1 234 567 8900",
      "email": "john.smith@email.com",
      "emergencyContact": "+1 234 567 8901",
    },
    "appointment": {
      "date": "2024-01-15",
      "time": "10:30",
      "duration": "30 minutes",
      "type": "Consultation",
      "reason": "Regular cardiac checkup and chest pain evaluation",
      "fee": 150.0,
      "paymentStatus": "Paid",
      "paymentMethod": "Credit Card",
      "insuranceClaimed": true,
    },
    "location": {
      "hospital": "City General Hospital",
      "address": "123 Medical Center Drive, Downtown",
      "room": "Room 205, Cardiology Department",
      "floor": "2nd Floor",
      "parking": "Available - Level 2",
    },
    "medicalInfo": {
      "symptoms": ["Chest pain", "Shortness of breath", "Fatigue"],
      "allergies": ["Penicillin", "Shellfish"],
      "currentMedications": ["Lisinopril 10mg", "Metformin 500mg"],
      "medicalHistory": ["Hypertension", "Type 2 Diabetes"],
      "vitalSigns": {
        "bloodPressure": "130/85 mmHg",
        "heartRate": "72 bpm",
        "temperature": "98.6°F",
        "weight": "180 lbs",
        "height": "5'10\"",
      },
    },
    "diagnosis": {
      "primary": "Hypertensive heart disease",
      "secondary": ["Chest wall pain", "Anxiety-related symptoms"],
      "recommendations": [
        "Continue current blood pressure medication",
        "Increase physical activity to 30 minutes daily",
        "Follow up in 3 months",
        "Consider stress management techniques",
      ],
      "prescriptions": [
        {
          "medication": "Lisinopril",
          "dosage": "10mg",
          "frequency": "Once daily",
          "duration": "Continue",
          "instructions": "Take in the morning with food",
        },
        {
          "medication": "Aspirin",
          "dosage": "81mg",
          "frequency": "Once daily",
          "duration": "Ongoing",
          "instructions": "Take with food to prevent stomach upset",
        },
      ],
      "labTests": [
        "Complete Blood Count (CBC)",
        "Lipid Panel",
        "HbA1c",
        "ECG",
      ],
    },
    "followUp": {
      "nextAppointment": "2024-04-15",
      "urgency": "Routine",
      "specialInstructions": "Monitor blood pressure daily and keep a log",
    },
    "documents": [
      {
        "type": "Prescription",
        "name": "Prescription_APT001.pdf",
        "url": "https://example.com/prescription.pdf",
      },
      {
        "type": "Lab Results",
        "name": "LabResults_APT001.pdf",
        "url": "https://example.com/labresults.pdf",
      },
      {
        "type": "Medical Report",
        "name": "MedicalReport_APT001.pdf",
        "url": "https://example.com/report.pdf",
      },
    ],
    "rating": {
      "stars": 5,
      "review": "Excellent consultation. Dr. Johnson was very thorough and explained everything clearly. Highly recommend!",
      "date": "2024-01-16",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
        actions: [
          IconButton(
            onPressed: () {
              _showMoreActions();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            _buildStatusHeader(),
            
            SizedBox(height: spMd),
            
            // Basic Information
            _buildBasicInfo(),
            
            SizedBox(height: spMd),
            
            // Doctor Information
            _buildDoctorInfo(),
            
            SizedBox(height: spMd),
            
            // Location Information
            _buildLocationInfo(),
            
            SizedBox(height: spMd),
            
            // Medical Information
            _buildMedicalInfo(),
            
            SizedBox(height: spMd),
            
            // Diagnosis & Treatment
            if (appointment["status"] == "Completed") ...[
              _buildDiagnosisInfo(),
              SizedBox(height: spMd),
            ],
            
            // Payment Information
            _buildPaymentInfo(),
            
            SizedBox(height: spMd),
            
            // Documents
            _buildDocuments(),
            
            SizedBox(height: spMd),
            
            // Follow-up Information
            if (appointment["status"] == "Completed") ...[
              _buildFollowUpInfo(),
              SizedBox(height: spMd),
            ],
            
            // Rating & Review
            if (appointment["rating"] != null) ...[
              _buildRatingReview(),
              SizedBox(height: spMd),
            ],
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }
  
  Widget _buildStatusHeader() {
    final status = appointment["status"] as String;
    Color statusColor = primaryColor;
    IconData statusIcon = Icons.info;
    
    switch (status) {
      case "Completed":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Confirmed":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        break;
      case "Cancelled":
        statusColor = dangerColor;
        statusIcon = Icons.cancel;
        break;
    }
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor, width: 2),
      ),
      child: Column(
        children: [
          Icon(statusIcon, color: statusColor, size: 48),
          SizedBox(height: spSm),
          Text(
            "Appointment $status",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "ID: ${appointment["id"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Created: ${DateTime.parse(appointment["createdDate"]).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBasicInfo() {
    return _buildCard("Appointment Information", [
      _buildInfoRow(Icons.calendar_today, "Date", DateTime.parse(appointment["appointment"]["date"]).dMMMy),
      _buildInfoRow(Icons.access_time, "Time", "${appointment["appointment"]["time"]}"),
      _buildInfoRow(Icons.timer, "Duration", "${appointment["appointment"]["duration"]}"),
      _buildInfoRow(Icons.medical_services, "Type", "${appointment["appointment"]["type"]}"),
      _buildInfoRow(Icons.description, "Reason", "${appointment["appointment"]["reason"]}"),
    ]);
  }
  
  Widget _buildDoctorInfo() {
    final doctor = appointment["doctor"];
    return _buildCard("Doctor Information", [
      Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${doctor["image"]}",
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
                    "${doctor["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${doctor["specialty"]} • ${doctor["qualification"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${doctor["experience"]} experience",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${doctor["rating"]}",
                        style: TextStyle(
                          fontSize: 12,
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
      SizedBox(height: spMd),
      _buildInfoRow(Icons.local_hospital, "Hospital", "${doctor["hospital"]}"),
      _buildInfoRow(Icons.phone, "Phone", "${doctor["phone"]}"),
      _buildInfoRow(Icons.email, "Email", "${doctor["email"]}"),
    ]);
  }
  
  Widget _buildLocationInfo() {
    final location = appointment["location"];
    return _buildCard("Location Details", [
      _buildInfoRow(Icons.local_hospital, "Hospital", "${location["hospital"]}"),
      _buildInfoRow(Icons.location_on, "Address", "${location["address"]}"),
      _buildInfoRow(Icons.room, "Room", "${location["room"]}"),
      _buildInfoRow(Icons.layers, "Floor", "${location["floor"]}"),
      _buildInfoRow(Icons.local_parking, "Parking", "${location["parking"]}"),
    ]);
  }
  
  Widget _buildMedicalInfo() {
    final medical = appointment["medicalInfo"];
    return _buildCard("Medical Information", [
      // Symptoms
      _buildListSection("Symptoms", Icons.sick, medical["symptoms"] as List),
      
      SizedBox(height: spMd),
      
      // Allergies
      _buildListSection("Allergies", Icons.warning, medical["allergies"] as List),
      
      SizedBox(height: spMd),
      
      // Current Medications
      _buildListSection("Current Medications", Icons.medication, medical["currentMedications"] as List),
      
      SizedBox(height: spMd),
      
      // Medical History
      _buildListSection("Medical History", Icons.history, medical["medicalHistory"] as List),
      
      SizedBox(height: spMd),
      
      // Vital Signs
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: infoColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: infoColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.monitor_heart, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Vital Signs",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(child: _buildVitalSign("BP", "${medical["vitalSigns"]["bloodPressure"]}")),
                Expanded(child: _buildVitalSign("HR", "${medical["vitalSigns"]["heartRate"]}")),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(child: _buildVitalSign("Temp", "${medical["vitalSigns"]["temperature"]}")),
                Expanded(child: _buildVitalSign("Weight", "${medical["vitalSigns"]["weight"]}")),
              ],
            ),
            SizedBox(height: spSm),
            _buildVitalSign("Height", "${medical["vitalSigns"]["height"]}"),
          ],
        ),
      ),
    ]);
  }
  
  Widget _buildDiagnosisInfo() {
    final diagnosis = appointment["diagnosis"];
    return _buildCard("Diagnosis & Treatment", [
      // Primary Diagnosis
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: primaryColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Primary Diagnosis",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${diagnosis["primary"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
      
      SizedBox(height: spMd),
      
      // Secondary Diagnosis
      if ((diagnosis["secondary"] as List).isNotEmpty) ...[
        _buildListSection("Secondary Diagnosis", Icons.assignment, diagnosis["secondary"] as List),
        SizedBox(height: spMd),
      ],
      
      // Recommendations
      _buildListSection("Recommendations", Icons.lightbulb, diagnosis["recommendations"] as List),
      
      SizedBox(height: spMd),
      
      // Prescriptions
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: successColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: successColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medication, color: successColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Prescriptions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            ...(diagnosis["prescriptions"] as List).map((prescription) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${prescription["medication"]} ${prescription["dosage"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${prescription["frequency"]} • ${prescription["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${prescription["instructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      
      SizedBox(height: spMd),
      
      // Lab Tests
      _buildListSection("Recommended Lab Tests", Icons.science, diagnosis["labTests"] as List),
    ]);
  }
  
  Widget _buildPaymentInfo() {
    final payment = appointment["appointment"];
    return _buildCard("Payment Information", [
      _buildInfoRow(Icons.payment, "Fee", "\$${(payment["fee"] as double).currency}"),
      _buildInfoRow(Icons.check_circle, "Status", "${payment["paymentStatus"]}"),
      _buildInfoRow(Icons.credit_card, "Method", "${payment["paymentMethod"]}"),
      _buildInfoRow(Icons.verified_user, "Insurance", payment["insuranceClaimed"] ? "Claimed" : "Not Claimed"),
    ]);
  }
  
  Widget _buildDocuments() {
    final documents = appointment["documents"] as List;
    return _buildCard("Documents", [
      ...documents.map((doc) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: GestureDetector(
            onTap: () {
              // Download or view document
              ss("Downloading ${doc["name"]}");
            },
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.file_present, color: primaryColor, size: 24),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${doc["type"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${doc["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.download, color: primaryColor, size: 20),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ]);
  }
  
  Widget _buildFollowUpInfo() {
    final followUp = appointment["followUp"];
    return _buildCard("Follow-up", [
      _buildInfoRow(Icons.event, "Next Appointment", DateTime.parse(followUp["nextAppointment"]).dMMMy),
      _buildInfoRow(Icons.priority_high, "Urgency", "${followUp["urgency"]}"),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: warningColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: warningColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Text(
                  "Special Instructions",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${followUp["specialInstructions"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
  
  Widget _buildRatingReview() {
    final rating = appointment["rating"];
    return _buildCard("Your Review", [
      Row(
        children: [
          ...List.generate(5, (index) {
            return Icon(
              index < (rating["stars"] as int) ? Icons.star : Icons.star_border,
              color: warningColor,
              size: 24,
            );
          }),
          SizedBox(width: spSm),
          Text(
            "${rating["stars"]}/5",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Text(
            "${DateTime.parse(rating["date"]).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
      SizedBox(height: spMd),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: warningColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Text(
          "${rating["review"]}",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
      ),
    ]);
  }
  
  Widget _buildCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
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
    );
  }
  
  Widget _buildListSection(String title, IconData icon, List items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: primaryColor, size: 16),
            SizedBox(width: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...items.map((item) {
          return Container(
            margin: EdgeInsets.only(bottom: spXs),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "$item",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
  
  Widget _buildVitalSign(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: infoColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildBottomActions() {
    final status = appointment["status"] as String;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          if (status == "Confirmed") ...[
            Expanded(
              child: QButton(
                label: "Reschedule",
                size: bs.md,
                color: warningColor,
                onPressed: () {
                  // navigateTo(RescheduleAppointmentView)
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Cancel",
                size: bs.md,
                color: dangerColor,
                onPressed: () {
                  // navigateTo(CancelAppointmentView)
                },
              ),
            ),
          ] else if (status == "Completed") ...[
            if (appointment["rating"] == null) ...[
              Expanded(
                child: QButton(
                  label: "Rate Doctor",
                  size: bs.md,
                  color: warningColor,
                  onPressed: () {
                    // navigateTo(RateDoctorView)
                  },
                ),
              ),
              SizedBox(width: spSm),
            ],
            Expanded(
              child: QButton(
                label: "Book Follow-up",
                size: bs.md,
                onPressed: () {
                  // navigateTo(BookAppointmentView)
                },
              ),
            ),
          ],
          
          if (status != "Confirmed") ...[
            SizedBox(width: spSm),
            QButton(
              label: "Download",
              size: bs.md,
              color: infoColor,
              onPressed: () {
                ss("Receipt downloaded successfully");
              },
            ),
          ],
        ],
      ),
    );
  }
  
  void _showMoreActions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "More Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(Icons.share, "Share Appointment", () {
                Navigator.pop(context);
                ss("Appointment details shared");
              }),
              _buildActionItem(Icons.print, "Print Details", () {
                Navigator.pop(context);
                ss("Printing appointment details");
              }),
              _buildActionItem(Icons.event, "Add to Calendar", () {
                Navigator.pop(context);
                ss("Added to calendar");
              }),
              _buildActionItem(Icons.support_agent, "Contact Support", () {
                Navigator.pop(context);
                // navigateTo(ContactSupportView)
              }),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildActionItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        margin: EdgeInsets.only(bottom: spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 24),
            SizedBox(width: spMd),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: disabledBoldColor, size: 16),
          ],
        ),
      ),
    );
  }
}
