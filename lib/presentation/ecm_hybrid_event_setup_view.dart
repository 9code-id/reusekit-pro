import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmHybridEventSetupView extends StatefulWidget {
  const EcmHybridEventSetupView({super.key});

  @override
  State<EcmHybridEventSetupView> createState() => _EcmHybridEventSetupViewState();
}

class _EcmHybridEventSetupViewState extends State<EcmHybridEventSetupView> {
  int inPersonCapacity = 100;
  int virtualCapacity = 500;
  String venueName = "Grand Conference Center";
  String venueAddress = "123 Business Ave, New York, NY 10001";
  String virtualPlatform = "Zoom";
  String meetingUrl = "";
  String meetingId = "";
  String meetingPassword = "";
  bool enableLiveStreaming = true;
  bool enableRecording = true;
  bool enableHybridInteraction = true;
  bool enableVirtualNetworking = true;
  bool enableDigitalWhiteboard = false;
  bool enableBreakoutRooms = true;
  bool enableQnA = true;
  bool enablePolls = true;
  bool enableChat = true;
  String registrationMode = "Combined";
  double inPersonTicketPrice = 150.0;
  double virtualTicketPrice = 50.0;
  String checkinMethod = "QR Code";
  bool provideTechSupport = true;
  String techSupportContact = "";
  String avEquipment = "";
  String internetRequirements = "";
  String streamingSetup = "";
  bool enableSimultaneousTranslation = false;
  List<String> translationLanguages = [];
  bool enableHybridNetworking = true;
  String networkingPlatform = "";
  bool enableVirtualExhibits = false;
  String exhibitPlatform = "";
  bool enableContentSharing = true;
  String contentSharingMethod = "";
  
  List<Map<String, dynamic>> platformItems = [
    {"label": "Zoom", "value": "Zoom"},
    {"label": "Microsoft Teams", "value": "Microsoft Teams"},
    {"label": "Webex", "value": "Webex"},
    {"label": "Google Meet", "value": "Google Meet"},
    {"label": "Custom Platform", "value": "Custom Platform"},
  ];

  List<Map<String, dynamic>> registrationModeItems = [
    {"label": "Combined Registration", "value": "Combined"},
    {"label": "Separate Registration", "value": "Separate"},
    {"label": "Venue-First Priority", "value": "Venue-First"},
  ];

  List<Map<String, dynamic>> checkinMethodItems = [
    {"label": "QR Code", "value": "QR Code"},
    {"label": "Mobile App", "value": "Mobile App"},
    {"label": "RFID Badge", "value": "RFID Badge"},
    {"label": "Manual Check-in", "value": "Manual Check-in"},
  ];

  List<Map<String, dynamic>> contentSharingItems = [
    {"label": "Live Stream to Virtual", "value": "Live Stream"},
    {"label": "Simultaneous Presentation", "value": "Simultaneous"},
    {"label": "Hybrid Screen Sharing", "value": "Hybrid Sharing"},
    {"label": "Cloud-based Sharing", "value": "Cloud Sharing"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hybrid Event Setup"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () => _saveHybridEventSetup(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOverviewSection(),
            _buildVenueSection(),
            _buildVirtualSection(),
            _buildCapacitySection(),
            _buildRegistrationSection(),
            _buildTechnologySection(),
            _buildInteractionSection(),
            _buildNetworkingSection(),
            _buildContentSection(),
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.merge_type,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Hybrid Event Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Configure your hybrid event to seamlessly combine in-person and virtual experiences. This setup allows attendees to participate either physically at the venue or remotely through digital platforms.",
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "In-Person",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "$inPersonCapacity attendees",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: primaryColor.withAlpha(30),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Icons.computer,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Virtual",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "$virtualCapacity attendees",
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
          ),
        ],
      ),
    );
  }

  Widget _buildVenueSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_city,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Physical Venue",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Venue Name",
            value: venueName,
            validator: Validator.required,
            onChanged: (value) {
              venueName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Venue Address",
            value: venueAddress,
            validator: Validator.required,
            onChanged: (value) {
              venueAddress = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Check-in Method",
            items: checkinMethodItems,
            value: checkinMethod,
            onChanged: (value, label) {
              checkinMethod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVirtualSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.laptop,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Virtual Platform",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Video Platform",
            items: platformItems,
            value: virtualPlatform,
            onChanged: (value, label) {
              virtualPlatform = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Meeting URL",
            value: meetingUrl,
            validator: Validator.required,
            hint: "https://zoom.us/j/123456789",
            onChanged: (value) {
              meetingUrl = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Meeting ID",
                  value: meetingId,
                  onChanged: (value) {
                    meetingId = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Meeting Password",
                  value: meetingPassword,
                  onChanged: (value) {
                    meetingPassword = value;
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

  Widget _buildCapacitySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Capacity Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "In-Person Capacity",
                  value: inPersonCapacity.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    inPersonCapacity = int.tryParse("$value") ?? 100;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Virtual Capacity",
                  value: virtualCapacity.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    virtualCapacity = int.tryParse("$value") ?? 500;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Total Event Capacity: ${inPersonCapacity + virtualCapacity} attendees",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "In-Person: ${((inPersonCapacity / (inPersonCapacity + virtualCapacity)) * 100).toStringAsFixed(1)}% • Virtual: ${((virtualCapacity / (inPersonCapacity + virtualCapacity)) * 100).toStringAsFixed(1)}%",
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
    );
  }

  Widget _buildRegistrationSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.app_registration,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Registration & Pricing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Registration Mode",
            items: registrationModeItems,
            value: registrationMode,
            onChanged: (value, label) {
              registrationMode = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "In-Person Ticket Price (\$)",
                  value: inPersonTicketPrice.toString(),
                  onChanged: (value) {
                    inPersonTicketPrice = double.tryParse("$value") ?? 150.0;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Virtual Ticket Price (\$)",
                  value: virtualTicketPrice.toString(),
                  onChanged: (value) {
                    virtualTicketPrice = double.tryParse("$value") ?? 50.0;
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

  Widget _buildTechnologySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_input_component,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Technology Requirements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "A/V Equipment Needed",
            value: avEquipment,
            hint: "List cameras, microphones, screens, and other equipment",
            onChanged: (value) {
              avEquipment = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Internet Requirements",
            value: internetRequirements,
            hint: "Bandwidth, connection redundancy, WiFi setup",
            onChanged: (value) {
              internetRequirements = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Streaming Setup",
            value: streamingSetup,
            hint: "How will in-person content be streamed to virtual attendees",
            onChanged: (value) {
              streamingSetup = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Hybrid Interaction Features",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Enable features that allow in-person and virtual attendees to interact:",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          QSwitch(
            items: [
              {"label": "Live Streaming to Virtual", "value": true, "checked": enableLiveStreaming},
              {"label": "Event Recording", "value": true, "checked": enableRecording},
              {"label": "Hybrid Q&A Sessions", "value": true, "checked": enableQnA},
              {"label": "Live Polls for All", "value": true, "checked": enablePolls},
              {"label": "Unified Chat System", "value": true, "checked": enableChat},
              {"label": "Virtual Breakout Rooms", "value": true, "checked": enableBreakoutRooms},
              {"label": "Digital Whiteboard", "value": true, "checked": enableDigitalWhiteboard},
            ],
            value: [
              if (enableLiveStreaming) {"label": "Live Streaming to Virtual", "value": true, "checked": true},
              if (enableRecording) {"label": "Event Recording", "value": true, "checked": true},
              if (enableQnA) {"label": "Hybrid Q&A Sessions", "value": true, "checked": true},
              if (enablePolls) {"label": "Live Polls for All", "value": true, "checked": true},
              if (enableChat) {"label": "Unified Chat System", "value": true, "checked": true},
              if (enableBreakoutRooms) {"label": "Virtual Breakout Rooms", "value": true, "checked": true},
              if (enableDigitalWhiteboard) {"label": "Digital Whiteboard", "value": true, "checked": true},
            ],
            onChanged: (values, ids) {
              setState(() {
                enableLiveStreaming = values.any((v) => v["label"] == "Live Streaming to Virtual");
                enableRecording = values.any((v) => v["label"] == "Event Recording");
                enableQnA = values.any((v) => v["label"] == "Hybrid Q&A Sessions");
                enablePolls = values.any((v) => v["label"] == "Live Polls for All");
                enableChat = values.any((v) => v["label"] == "Unified Chat System");
                enableBreakoutRooms = values.any((v) => v["label"] == "Virtual Breakout Rooms");
                enableDigitalWhiteboard = values.any((v) => v["label"] == "Digital Whiteboard");
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.group_work,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Networking & Exhibits",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Hybrid Networking",
                "value": true,
                "checked": enableHybridNetworking,
              }
            ],
            value: [if (enableHybridNetworking) {"label": "Enable Hybrid Networking", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                enableHybridNetworking = values.isNotEmpty;
              });
            },
          ),
          if (enableHybridNetworking)
            QTextField(
              label: "Networking Platform",
              value: networkingPlatform,
              hint: "Platform for virtual networking (e.g., Remo, Hopin)",
              onChanged: (value) {
                networkingPlatform = value;
                setState(() {});
              },
            ),
          QSwitch(
            items: [
              {
                "label": "Enable Virtual Exhibits",
                "value": true,
                "checked": enableVirtualExhibits,
              }
            ],
            value: [if (enableVirtualExhibits) {"label": "Enable Virtual Exhibits", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                enableVirtualExhibits = values.isNotEmpty;
              });
            },
          ),
          if (enableVirtualExhibits)
            QTextField(
              label: "Virtual Exhibit Platform",
              value: exhibitPlatform,
              hint: "Platform for virtual exhibition booths",
              onChanged: (value) {
                exhibitPlatform = value;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.screen_share,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Content & Translation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Enable Content Sharing",
                "value": true,
                "checked": enableContentSharing,
              }
            ],
            value: [if (enableContentSharing) {"label": "Enable Content Sharing", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                enableContentSharing = values.isNotEmpty;
              });
            },
          ),
          if (enableContentSharing)
            QDropdownField(
              label: "Content Sharing Method",
              items: contentSharingItems,
              value: contentSharingMethod,
              onChanged: (value, label) {
                contentSharingMethod = value;
                setState(() {});
              },
            ),
          QSwitch(
            items: [
              {
                "label": "Enable Simultaneous Translation",
                "value": true,
                "checked": enableSimultaneousTranslation,
              }
            ],
            value: [if (enableSimultaneousTranslation) {"label": "Enable Simultaneous Translation", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                enableSimultaneousTranslation = values.isNotEmpty;
              });
            },
          ),
          if (enableSimultaneousTranslation) ...[
            if (translationLanguages.isNotEmpty) ...[
              Text(
                "Translation Languages:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  fontSize: 14,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: translationLanguages.map((language) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          language,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () {
                            translationLanguages.remove(language);
                            setState(() {});
                          },
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Add Language",
                    value: "",
                    hint: "e.g., Spanish, French, German",
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Add",
                  size: bs.sm,
                  onPressed: () => _addTranslationLanguage(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.support_agent,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Technical Support",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Provide On-site Technical Support",
                "value": true,
                "checked": provideTechSupport,
              }
            ],
            value: [if (provideTechSupport) {"label": "Provide On-site Technical Support", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                provideTechSupport = values.isNotEmpty;
              });
            },
          ),
          QTextField(
            label: "Technical Support Contact",
            value: techSupportContact,
            validator: Validator.required,
            hint: "Contact information for technical issues",
            onChanged: (value) {
              techSupportContact = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  void _addTranslationLanguage() {
    translationLanguages.add("Spanish");
    setState(() {});
    ss("Translation language added");
  }

  void _saveHybridEventSetup() {
    ss("Hybrid event setup saved successfully");
  }
}
