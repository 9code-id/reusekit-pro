import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvitation4View extends StatefulWidget {
  @override
  State<GrlInvitation4View> createState() => _GrlInvitation4ViewState();
}

class _GrlInvitation4ViewState extends State<GrlInvitation4View> {
  final formKey = GlobalKey<FormState>();
  String eventName = "";
  String selectedDate = DateTime.now().toString();
  String selectedTime = TimeOfDay.now().kkmm;
  String location = "";
  String description = "";
  String hostName = "";
  String contactInfo = "";
  bool isPublic = true;
  String selectedCategory = "Social";
  int maxAttendees = 50;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Social", "value": "Social"},
    {"label": "Business", "value": "Business"},
    {"label": "Educational", "value": "Educational"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Health", "value": "Health"},
  ];

  List<Map<String, dynamic>> invitations = [
    {
      "id": 1,
      "title": "Annual Team Building",
      "date": "2024-02-15",
      "time": "09:00",
      "location": "Mountain Resort",
      "category": "Business",
      "attendees": 25,
      "maxAttendees": 50,
      "status": "confirmed",
      "image": "https://picsum.photos/400/200?random=1&keyword=team"
    },
    {
      "id": 2,
      "title": "Birthday Celebration",
      "date": "2024-02-20",
      "time": "18:00",
      "location": "Garden Restaurant",
      "category": "Social",
      "attendees": 15,
      "maxAttendees": 30,
      "status": "pending",
      "image": "https://picsum.photos/400/200?random=2&keyword=birthday"
    },
    {
      "id": 3,
      "title": "Tech Conference 2024",
      "date": "2024-03-05",
      "time": "08:00",
      "location": "Convention Center",
      "category": "Educational",
      "attendees": 150,
      "maxAttendees": 200,
      "status": "confirmed",
      "image": "https://picsum.photos/400/200?random=3&keyword=conference"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Invitation"),
        actions: [
          QButton(
            icon: Icons.send,
            size: bs.sm,
            onPressed: () => _sendInvitation(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEventDetails(),
              _buildDateTime(),
              _buildLocationAndHost(),
              _buildEventSettings(),
              _buildInvitationPreview(),
              _buildRecentInvitations(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Event Name",
            value: eventName,
            hint: "Enter event name",
            validator: Validator.required,
            onChanged: (value) {
              eventName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Category",
            items: categoryItems,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe your event",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateTime() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date & Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Event Date",
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
                  label: "Event Time",
                  value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $selectedTime:00")),
                  onChanged: (value) {
                    selectedTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAndHost() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location & Host",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Location",
            value: location,
            hint: "Enter event location",
            validator: Validator.required,
            onChanged: (value) {
              location = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Host Name",
                  value: hostName,
                  hint: "Enter host name",
                  validator: Validator.required,
                  onChanged: (value) {
                    hostName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Contact Info",
                  value: contactInfo,
                  hint: "Phone or email",
                  validator: Validator.required,
                  onChanged: (value) {
                    contactInfo = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Max Attendees",
                  value: maxAttendees.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    maxAttendees = int.tryParse(value) ?? 50;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event Type",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    QSwitch(
                      items: [
                        {
                          "label": "Public Event",
                          "value": true,
                          "checked": isPublic,
                        }
                      ],
                      value: [
                        if (isPublic)
                          {
                            "label": "Public Event",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isPublic = values.isNotEmpty;
                        setState(() {});
                      },
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

  Widget _buildInvitationPreview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName.isEmpty ? "Event Name" : eventName,
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${DateTime.parse(selectedDate).dMMMy} at $selectedTime",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        location.isEmpty ? "Event Location" : location,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentInvitations() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Invitations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...invitations.map((invitation) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${invitation["image"]}",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${invitation["title"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${invitation["category"]} • ${invitation["attendees"]}/${invitation["maxAttendees"]} attendees",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${DateTime.parse(invitation["date"]).dMMMy}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: invitation["status"] == "confirmed" ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${invitation["status"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  void _sendInvitation() {
    if (formKey.currentState!.validate()) {
      ss("Invitation sent successfully!");
    }
  }
}
