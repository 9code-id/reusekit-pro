import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAttendeeView extends StatefulWidget {
  const EmaAttendeeView({super.key});

  @override
  State<EmaAttendeeView> createState() => _EmaAttendeeViewState();
}

class _EmaAttendeeViewState extends State<EmaAttendeeView> {
  Map<String, dynamic> attendeeData = {
    "id": "ATT-001",
    "ticket_id": "TKT-001-001",
    "qr_code": "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=TKT-001-001",
    "personal_info": {
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "+1-555-0123",
      "company": "Tech Solutions Inc",
      "job_title": "Senior Developer",
      "linkedin": "linkedin.com/in/johndoe",
      "dietary_requirements": "Vegetarian",
      "accessibility_needs": "None",
      "emergency_contact": {
        "name": "Jane Doe",
        "phone": "+1-555-0124",
        "relationship": "Spouse"
      }
    },
    "ticket_info": {
      "type": "Regular",
      "category": "General Admission",
      "price": 150.0,
      "benefits": ["Conference Access", "Lunch Included", "Welcome Kit", "Networking Session"]
    },
    "event": {
      "title": "Flutter Conference 2024",
      "date": "2024-07-15",
      "start_time": "09:00",
      "end_time": "18:00",
      "location": "Grand Convention Center",
      "address": "123 Tech Street, Digital City, DC 12345",
      "image": "https://picsum.photos/400/200?random=1&keyword=conference"
    },
    "check_in_status": "Not Checked In",
    "check_in_time": null,
    "sessions_registered": [
      {
        "id": "S001",
        "title": "Flutter State Management",
        "speaker": "Jane Smith",
        "time": "10:00 - 11:00",
        "room": "Room A"
      },
      {
        "id": "S002", 
        "title": "Advanced Flutter Animations",
        "speaker": "Mike Johnson",
        "time": "14:00 - 15:00",
        "room": "Room B"
      }
    ],
    "networking_preferences": {
      "interests": ["Mobile Development", "UI/UX", "State Management"],
      "looking_for": ["Job Opportunities", "Collaboration", "Mentorship"],
      "availability": "Available for networking during breaks"
    }
  };

  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendee Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //navigateTo EmaAttendeeManagementView
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Attendee profile shared");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAttendeeHeader(),
          _buildTabBar(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildAttendeeHeader() {
    final personalInfo = attendeeData["personal_info"] as Map<String, dynamic>;
    final ticketInfo = attendeeData["ticket_info"] as Map<String, dynamic>;
    final checkInStatus = attendeeData["check_in_status"] as String;
    
    Color statusColor = checkInStatus == "Checked In" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: primaryColor.withAlpha(50),
                child: Text(
                  "${(personalInfo["name"] as String).substring(0, 2).toUpperCase()}",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${personalInfo["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${personalInfo["job_title"]} at ${personalInfo["company"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.email, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${personalInfo["email"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  checkInStatus,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildInfoCard("Ticket Type", "${ticketInfo["type"]}", Icons.confirmation_number),
              ),
              Expanded(
                child: _buildInfoCard("Ticket ID", "${attendeeData["ticket_id"]}", Icons.qr_code),
              ),
              Expanded(
                child: _buildInfoCard("Price", "\$${((ticketInfo["price"] as double)).currency}", Icons.attach_money),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: primaryColor, size: 20),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ["Details", "Ticket", "Sessions", "QR Code"];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = selectedTabIndex == index;
            
            return GestureDetector(
              onTap: () {
                selectedTabIndex = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spLg, vertical: spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? primaryColor : disabledBoldColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return _buildDetailsTab();
      case 1:
        return _buildTicketTab();
      case 2:
        return _buildSessionsTab();
      case 3:
        return _buildQrCodeTab();
      default:
        return _buildDetailsTab();
    }
  }

  Widget _buildDetailsTab() {
    final personalInfo = attendeeData["personal_info"] as Map<String, dynamic>;
    final emergencyContact = personalInfo["emergency_contact"] as Map<String, dynamic>;
    final networkingPrefs = attendeeData["networking_preferences"] as Map<String, dynamic>;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDetailRow(Icons.person, "Full Name", "${personalInfo["name"]}"),
                _buildDetailRow(Icons.email, "Email", "${personalInfo["email"]}"),
                _buildDetailRow(Icons.phone, "Phone", "${personalInfo["phone"]}"),
                _buildDetailRow(Icons.business, "Company", "${personalInfo["company"]}"),
                _buildDetailRow(Icons.work, "Job Title", "${personalInfo["job_title"]}"),
                _buildDetailRow(Icons.link, "LinkedIn", "${personalInfo["linkedin"]}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Special Requirements",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDetailRow(Icons.restaurant, "Dietary", "${personalInfo["dietary_requirements"]}"),
                _buildDetailRow(Icons.accessible, "Accessibility", "${personalInfo["accessibility_needs"]}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Emergency Contact",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDetailRow(Icons.person, "Name", "${emergencyContact["name"]}"),
                _buildDetailRow(Icons.phone, "Phone", "${emergencyContact["phone"]}"),
                _buildDetailRow(Icons.family_restroom, "Relationship", "${emergencyContact["relationship"]}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Networking Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildInterestsSection("Interests", networkingPrefs["interests"] as List),
                _buildInterestsSection("Looking For", networkingPrefs["looking_for"] as List),
                _buildDetailRow(Icons.schedule, "Availability", "${networkingPrefs["availability"]}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: primaryColor),
        SizedBox(width: spSm),
        Text(
          "$label:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection(String title, List interests) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.interests, size: 18, color: primaryColor),
            SizedBox(width: spSm),
            Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: interests.map((interest) => Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "$interest",
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildTicketTab() {
    final ticketInfo = attendeeData["ticket_info"] as Map<String, dynamic>;
    final event = attendeeData["event"] as Map<String, dynamic>;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Ticket Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDetailRow(Icons.confirmation_number, "Ticket ID", "${attendeeData["ticket_id"]}"),
                _buildDetailRow(Icons.local_activity, "Type", "${ticketInfo["type"]}"),
                _buildDetailRow(Icons.category, "Category", "${ticketInfo["category"]}"),
                _buildDetailRow(Icons.attach_money, "Price", "\$${((ticketInfo["price"] as double)).currency}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Event Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${event["image"]}",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDetailRow(Icons.calendar_today, "Date", "${DateTime.parse(event["date"]).dMMMy}"),
                _buildDetailRow(Icons.access_time, "Time", "${event["start_time"]} - ${event["end_time"]}"),
                _buildDetailRow(Icons.location_on, "Venue", "${event["location"]}"),
                _buildDetailRow(Icons.place, "Address", "${event["address"]}"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Ticket Benefits",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...(ticketInfo["benefits"] as List).map((benefit) => Row(
                  children: [
                    Icon(Icons.check_circle, size: 16, color: successColor),
                    SizedBox(width: spSm),
                    Text(
                      "$benefit",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsTab() {
    final sessions = attendeeData["sessions_registered"] as List;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(Icons.event, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Registered Sessions (${sessions.length})",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ...sessions.map((session) => Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${session["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text("${session["speaker"]}"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text("${session["time"]}"),
                    SizedBox(width: spMd),
                    Icon(Icons.room, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text("${session["room"]}"),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Session Details",
                    size: bs.sm,
                    onPressed: () {
                      ss("Viewing session: ${session["title"]}");
                    },
                  ),
                ),
              ],
            ),
          )),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Browse All Sessions",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                //navigateTo sessions
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrCodeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Show this QR code at the event entrance for quick check-in. Keep your phone charged!",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Text(
                  "Event Check-in QR Code",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowMd],
                  ),
                  child: Image.network(
                    "${attendeeData["qr_code"]}",
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Ticket ID: ${attendeeData["ticket_id"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${attendeeData["personal_info"]["name"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save to Gallery",
                  icon: Icons.download,
                  size: bs.md,
                  onPressed: () {
                    ss("QR code saved to gallery");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Share QR Code",
                  icon: Icons.share,
                  size: bs.md,
                  onPressed: () {
                    ss("QR code shared");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    final checkInStatus = attendeeData["check_in_status"] as String;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          if (checkInStatus != "Checked In")
            Expanded(
              child: QButton(
                label: "Check In",
                icon: Icons.qr_code_scanner,
                size: bs.md,
                onPressed: () {
                  //navigateTo EmaCheckInView
                },
              ),
            ),
          Expanded(
            child: QButton(
              label: "Contact Support",
              icon: Icons.support,
              size: bs.md,
              onPressed: () {
                //navigateTo support
              },
            ),
          ),
        ],
      ),
    );
  }
}
