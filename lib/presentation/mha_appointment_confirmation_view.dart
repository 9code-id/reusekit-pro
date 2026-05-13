import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaAppointmentConfirmationView extends StatefulWidget {
  const MhaAppointmentConfirmationView({super.key});

  @override
  State<MhaAppointmentConfirmationView> createState() => _MhaAppointmentConfirmationViewState();
}

class _MhaAppointmentConfirmationViewState extends State<MhaAppointmentConfirmationView> {
  final Map<String, dynamic> appointment = {
    "id": "APT001",
    "doctor": {
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "image": "https://picsum.photos/300/300?random=1&keyword=doctor",
      "hospital": "City General Hospital",
      "rating": 4.8,
    },
    "patient": {
      "name": "John Smith",
      "age": 35,
      "phone": "+1 234 567 8900",
      "email": "john.smith@email.com",
    },
    "appointment": {
      "date": "2024-01-15",
      "time": "10:30",
      "type": "Consultation",
      "duration": "30 minutes",
      "fee": 150.0,
      "status": "Confirmed",
    },
    "location": {
      "hospital": "City General Hospital",
      "address": "123 Medical Center Drive, Downtown",
      "room": "Room 205, Cardiology Department",
      "parking": "Available - Level 2",
    },
    "instructions": [
      "Please arrive 15 minutes before your appointment",
      "Bring your insurance card and ID",
      "Bring list of current medications",
      "Fast for 8 hours if blood tests are required",
      "Wear comfortable clothing",
    ],
    "contactInfo": {
      "phone": "+1 555 0123",
      "email": "appointments@cityhospital.com",
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Confirmed"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // navigateTo(HomeView)
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Animation/Icon
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXl),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Appointment Confirmed!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Your appointment has been successfully booked",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // Appointment Details Card
            Container(
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
                    "Appointment Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Appointment ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Appointment ID",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${appointment["id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Date & Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${DateTime.parse(appointment["appointment"]["date"]).dMMMy} at ${appointment["appointment"]["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${appointment["appointment"]["duration"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Type",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${appointment["appointment"]["type"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Fee
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Consultation Fee",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(appointment["appointment"]["fee"] as double).currency}",
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
            
            SizedBox(height: spMd),
            
            // Doctor Information Card
            Container(
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
                    "Doctor Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
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
                            "${appointment["doctor"]["image"]}",
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
                              "${appointment["doctor"]["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${appointment["doctor"]["specialty"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${appointment["doctor"]["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.local_hospital, color: primaryColor, size: 16),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${appointment["doctor"]["hospital"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Location Information Card
            Container(
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
                    "Location Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  _buildLocationRow(Icons.local_hospital, "Hospital", "${appointment["location"]["hospital"]}"),
                  _buildLocationRow(Icons.location_on, "Address", "${appointment["location"]["address"]}"),
                  _buildLocationRow(Icons.room, "Room", "${appointment["location"]["room"]}"),
                  _buildLocationRow(Icons.local_parking, "Parking", "${appointment["location"]["parking"]}"),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Instructions Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Important Instructions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ...(appointment["instructions"] as List).map((instruction) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "$instruction",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
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
            
            // Contact Information Card
            Container(
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
                    "Need Help?",
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
                        child: GestureDetector(
                          onTap: () {
                            // Call hospital
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.phone, color: primaryColor, size: 24),
                                SizedBox(height: spXs),
                                Text(
                                  "Call Hospital",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${appointment["contactInfo"]["phone"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Send email
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.email, color: infoColor, size: 24),
                                SizedBox(height: spXs),
                                Text(
                                  "Send Email",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${appointment["contactInfo"]["email"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Add to Calendar",
                size: bs.md,
                color: infoColor,
                onPressed: () {
                  // Add to calendar
                  ss("Appointment added to calendar");
                },
              ),
            ),
            
            SizedBox(width: spSm),
            
            Expanded(
              child: QButton(
                label: "View Appointments",
                size: bs.md,
                onPressed: () {
                  // navigateTo(AppointmentHistoryView)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLocationRow(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 120,
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
        ],
      ),
    );
  }
}
