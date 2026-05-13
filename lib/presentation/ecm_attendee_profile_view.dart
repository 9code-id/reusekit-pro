import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmAttendeeProfileView extends StatefulWidget {
  const EcmAttendeeProfileView({super.key});

  @override
  State<EcmAttendeeProfileView> createState() => _EcmAttendeeProfileViewState();
}

class _EcmAttendeeProfileViewState extends State<EcmAttendeeProfileView> {
  bool isEditing = false;
  
  Map<String, dynamic> attendee = {
    "id": 1,
    "name": "Alex Johnson",
    "email": "alex.johnson@company.com",
    "company": "Tech Solutions Inc",
    "position": "Senior Developer",
    "ticket_type": "VIP",
    "checked_in": true,
    "check_in_time": "2024-06-19 09:15:00",
    "avatar": "https://picsum.photos/150/150?random=1&face",
    "phone": "+1 555-0123",
    "dietary_requirements": "Vegetarian",
    "badge_printed": true,
    "registration_date": "2024-05-15 14:30:00",
    "qr_code": "ATT-2024-001-VIP",
    "emergency_contact": "Jane Johnson - +1 555-0199",
    "linkedin": "https://linkedin.com/in/alexjohnson",
    "twitter": "@alexjohnson",
    "bio": "Experienced senior developer with 8+ years in full-stack development. Passionate about clean code and scalable architecture.",
    "interests": ["AI/ML", "Cloud Computing", "DevOps", "Mobile Development"],
    "session_attendance": [
      {
        "session": "Keynote: Future of Technology",
        "time": "09:00 - 10:00",
        "attended": true,
      },
      {
        "session": "AI in Modern Development",
        "time": "10:30 - 11:30",
        "attended": true,
      },
      {
        "session": "Cloud Architecture Best Practices",
        "time": "14:00 - 15:00",
        "attended": false,
      },
    ],
    "networking_connections": 12,
    "meetings_scheduled": 3,
  };

  String name = "";
  String email = "";
  String company = "";
  String position = "";
  String phone = "";
  String dietaryRequirements = "";
  String emergencyContact = "";

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    name = attendee["name"];
    email = attendee["email"];
    company = attendee["company"];
    position = attendee["position"];
    phone = attendee["phone"];
    dietaryRequirements = attendee["dietary_requirements"];
    emergencyContact = attendee["emergency_contact"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendee Profile"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _saveChanges();
              } else {
                isEditing = true;
                setState(() {});
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildProfileHeader(),
            _buildBasicInfo(),
            _buildContactInfo(),
            _buildEventInfo(),
            _buildSessionAttendance(),
            _buildNetworkingStats(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage("${attendee["avatar"]}"),
          ),
          SizedBox(height: spSm),
          Text(
            "${attendee["name"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${attendee["position"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${attendee["company"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: attendee["ticket_type"] == "VIP" ? warningColor : infoColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${attendee["ticket_type"]} Ticket",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (attendee["checked_in"] as bool) ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      (attendee["checked_in"] as bool) ? Icons.check_circle : Icons.access_time,
                      size: 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      (attendee["checked_in"] as bool) ? "Checked In" : "Pending",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Container(
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
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (isEditing) ...[
            QTextField(
              label: "Full Name",
              value: name,
              onChanged: (value) {
                name = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Email",
              value: email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Company",
              value: company,
              onChanged: (value) {
                company = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Position",
              value: position,
              onChanged: (value) {
                position = value;
                setState(() {});
              },
            ),
          ] else ...[
            _buildInfoRow("Email", "${attendee["email"]}", Icons.email),
            _buildInfoRow("Company", "${attendee["company"]}", Icons.business),
            _buildInfoRow("Position", "${attendee["position"]}", Icons.work),
            _buildInfoRow("Registration", "${attendee["registration_date"]}", Icons.calendar_today),
            _buildInfoRow("QR Code", "${attendee["qr_code"]}", Icons.qr_code),
          ],
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
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
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (isEditing) ...[
            QTextField(
              label: "Phone",
              value: phone,
              onChanged: (value) {
                phone = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Dietary Requirements",
              value: dietaryRequirements,
              onChanged: (value) {
                dietaryRequirements = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Emergency Contact",
              value: emergencyContact,
              onChanged: (value) {
                emergencyContact = value;
                setState(() {});
              },
            ),
          ] else ...[
            _buildInfoRow("Phone", "${attendee["phone"]}", Icons.phone),
            _buildInfoRow("Dietary Requirements", "${attendee["dietary_requirements"]}", Icons.restaurant),
            _buildInfoRow("Emergency Contact", "${attendee["emergency_contact"]}", Icons.emergency),
            if (attendee["linkedin"] != null)
              _buildInfoRow("LinkedIn", "${attendee["linkedin"]}", Icons.link),
            if (attendee["twitter"] != null)
              _buildInfoRow("Twitter", "${attendee["twitter"]}", Icons.link),
          ],
        ],
      ),
    );
  }

  Widget _buildEventInfo() {
    return Container(
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
            "Event Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (attendee["checked_in"] as bool) ...[
            _buildInfoRow("Check-in Time", "${attendee["check_in_time"]}", Icons.access_time),
            _buildInfoRow("Badge Status", (attendee["badge_printed"] as bool) ? "Printed" : "Not Printed", Icons.badge),
          ],
          if (attendee["bio"] != null) ...[
            SizedBox(height: spSm),
            Text(
              "Bio",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${attendee["bio"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
          if (attendee["interests"] != null) ...[
            SizedBox(height: spSm),
            Text(
              "Interests",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (attendee["interests"] as List).map((interest) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: infoColor, width: 1),
                  ),
                  child: Text(
                    "$interest",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSessionAttendance() {
    return Container(
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
            "Session Attendance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...(attendee["session_attendance"] as List).map((session) {
            bool attended = session["attended"] as bool;
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: attended ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: attended ? successColor : dangerColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    attended ? Icons.check_circle : Icons.cancel,
                    size: 16,
                    color: attended ? successColor : dangerColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${session["session"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${session["time"]}",
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
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNetworkingStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people,
                  size: 24,
                  color: primaryColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "${attendee["networking_connections"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Connections",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.event,
                  size: 24,
                  color: infoColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "${attendee["meetings_scheduled"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Meetings",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QButton(
                label: !(attendee["checked_in"] as bool) ? "Check In" : "Check Out",
                size: bs.sm,
                onPressed: () {
                  bool isCheckedIn = attendee["checked_in"] as bool;
                  attendee["checked_in"] = !isCheckedIn;
                  if (!isCheckedIn) {
                    attendee["check_in_time"] = DateTime.now().toString();
                    ss("Attendee checked in successfully");
                  } else {
                    ss("Attendee checked out successfully");
                  }
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            if (!(attendee["badge_printed"] as bool))
              Expanded(
                child: QButton(
                  label: "Print Badge",
                  size: bs.sm,
                  onPressed: () {
                    attendee["badge_printed"] = true;
                    setState(() {});
                    ss("Badge printed successfully");
                  },
                ),
              ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Send Message",
                size: bs.sm,
                onPressed: () {
                  si("Message feature not implemented");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "View QR Code",
                size: bs.sm,
                onPressed: () {
                  si("QR Code viewer not implemented");
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
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
    );
  }

  void _saveChanges() {
    attendee["name"] = name;
    attendee["email"] = email;
    attendee["company"] = company;
    attendee["position"] = position;
    attendee["phone"] = phone;
    attendee["dietary_requirements"] = dietaryRequirements;
    attendee["emergency_contact"] = emergencyContact;
    
    isEditing = false;
    setState(() {});
    ss("Profile updated successfully");
  }
}
