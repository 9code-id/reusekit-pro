import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaEventRsvpView extends StatefulWidget {
  const SmaEventRsvpView({super.key});

  @override
  State<SmaEventRsvpView> createState() => _SmaEventRsvpViewState();
}

class _SmaEventRsvpViewState extends State<SmaEventRsvpView> {
  String selectedResponse = "";
  String guestCount = "1";
  String specialRequests = "";
  String dietaryRestrictions = "";
  bool allowContactFromOrganizer = true;
  bool receiveEventUpdates = true;
  
  Map<String, dynamic> eventData = {
    "id": 1,
    "title": "Tech Innovation Summit 2024",
    "date": "2024-06-20",
    "time": "09:00",
    "location": "San Francisco Convention Center",
    "address": "747 Howard St, San Francisco, CA 94103",
    "image": "https://picsum.photos/400/200?random=1&keyword=conference",
    "organizer": "TechCorp",
    "organizerImage": "https://picsum.photos/60/60?random=1&keyword=tech",
    "description": "Join industry leaders for a day of innovation and networking.",
    "category": "Conference",
    "price": 0,
    "currentAttendees": 1250,
    "maxAttendees": 2000,
    "requiresApproval": false,
    "allowsPlusOnes": true,
    "deadline": "2024-06-18"
  };

  List<Map<String, dynamic>> responseOptions = [
    {
      "value": "going",
      "label": "Going",
      "description": "I will definitely attend this event",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "value": "interested",
      "label": "Interested",
      "description": "I'm interested but not sure if I can attend",
      "icon": Icons.star,
      "color": warningColor
    },
    {
      "value": "maybe",
      "label": "Maybe",
      "description": "I might attend if circumstances allow",
      "icon": Icons.help,
      "color": infoColor
    },
    {
      "value": "not_going",
      "label": "Can't Go",
      "description": "I won't be able to attend this event",
      "icon": Icons.cancel,
      "color": dangerColor
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RSVP"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Event Summary Card
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Event Image
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${eventData["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(128),
                            ],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${eventData["category"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Event Info
                    Text(
                      "${eventData["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${eventData["organizerImage"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Organized by ${eventData["organizer"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(eventData["date"] as String).dMMMy} at ${eventData["time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Free",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Location
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${eventData["location"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${eventData["address"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Event Stats
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((eventData["currentAttendees"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Going",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: disabledColor,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((eventData["maxAttendees"] as int) - (eventData["currentAttendees"] as int))}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Spots Left",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: disabledColor,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${DateTime.parse(eventData["deadline"] as String).difference(DateTime.now()).inDays}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Days Left",
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
                  ],
                ),
              ),
            ),

            // RSVP Response Selection
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Your Response",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    ...responseOptions.map((option) {
                      bool isSelected = selectedResponse == option["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedResponse = option["value"] as String;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? (option["color"] as Color).withAlpha(25)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected 
                                  ? (option["color"] as Color)
                                  : disabledColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                option["icon"] as IconData,
                                color: isSelected 
                                    ? (option["color"] as Color)
                                    : disabledBoldColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${option["label"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected 
                                            ? (option["color"] as Color)
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      "${option["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected) ...[
                                Icon(
                                  Icons.check,
                                  color: option["color"] as Color,
                                  size: 20,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            // Additional Details (shown only if going)
            if (selectedResponse == "going") ...[
              Card(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Additional Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      if (eventData["allowsPlusOnes"] as bool) ...[
                        QNumberField(
                          label: "Number of Guests",
                          value: guestCount,
                          hint: "Including yourself",
                          onChanged: (value) {
                            guestCount = value;
                            setState(() {});
                          },
                        ),
                      ],
                      
                      QTextField(
                        label: "Dietary Restrictions",
                        value: dietaryRestrictions,
                        hint: "Any food allergies or dietary preferences",
                        onChanged: (value) {
                          dietaryRestrictions = value;
                          setState(() {});
                        },
                      ),
                      
                      QMemoField(
                        label: "Special Requests",
                        value: specialRequests,
                        hint: "Accessibility needs, special seating, etc.",
                        onChanged: (value) {
                          specialRequests = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Communication Preferences
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Communication Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    QSwitch(
                      label: "Event Updates",
                      items: [
                        {
                          "label": "Receive event updates and reminders",
                          "value": true,
                          "checked": receiveEventUpdates,
                        }
                      ],
                      value: [
                        if (receiveEventUpdates)
                          {
                            "label": "Receive event updates and reminders",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        receiveEventUpdates = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      label: "Organizer Contact",
                      items: [
                        {
                          "label": "Allow organizer to contact me directly",
                          "value": true,
                          "checked": allowContactFromOrganizer,
                        }
                      ],
                      value: [
                        if (allowContactFromOrganizer)
                          {
                            "label": "Allow organizer to contact me directly",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        allowContactFromOrganizer = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Approval Notice (if required)
            if (eventData["requiresApproval"] as bool && selectedResponse == "going") ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(76)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.pending,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Approval Required",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Your attendance request will be reviewed by the organizer. You'll receive a notification once approved.",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: selectedResponse.isEmpty 
                    ? "Select Your Response"
                    : selectedResponse == "going"
                        ? "Confirm Attendance"
                        : "Submit Response",
                size: bs.md,
                onPressed: selectedResponse.isEmpty ? null : () async {
                  showLoading();
                  await Future.delayed(Duration(seconds: 2));
                  hideLoading();
                  
                  String message = "";
                  switch (selectedResponse) {
                    case "going":
                      message = "Great! You're registered for the event.";
                      break;
                    case "interested":
                      message = "Thanks! We've noted your interest.";
                      break;
                    case "maybe":
                      message = "Thanks! We'll send you reminders.";
                      break;
                    case "not_going":
                      message = "Thanks for letting us know.";
                      break;
                  }
                  
                  ss(message);
                  back();
                },
              ),
            ),

            // Event Description
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "About This Event",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${eventData["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
