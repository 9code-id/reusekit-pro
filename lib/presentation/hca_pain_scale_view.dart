import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPainScaleView extends StatefulWidget {
  const HcaPainScaleView({super.key});

  @override
  State<HcaPainScaleView> createState() => _HcaPainScaleViewState();
}

class _HcaPainScaleViewState extends State<HcaPainScaleView> {
  int currentPainLevel = 0;
  String selectedPainType = "";
  String selectedLocation = "";
  String painDescription = "";
  bool isLogging = false;

  List<Map<String, dynamic>> painHistory = [
    {
      "id": "1",
      "date": "2024-06-19",
      "time": "14:30",
      "level": 7,
      "type": "Sharp",
      "location": "Lower back",
      "description": "Sharp pain when bending over",
      "triggers": ["Movement", "Sitting too long"],
      "relief": ["Heat pad", "Stretching"],
      "duration": "2 hours",
    },
    {
      "id": "2",
      "date": "2024-06-18",
      "time": "09:15",
      "level": 4,
      "type": "Dull ache",
      "location": "Neck",
      "description": "Stiff neck after sleeping",
      "triggers": ["Poor sleep position"],
      "relief": ["Gentle massage"],
      "duration": "1 hour",
    },
    {
      "id": "3",
      "date": "2024-06-17",
      "time": "16:45",
      "level": 8,
      "type": "Throbbing",
      "location": "Head",
      "description": "Severe headache with nausea",
      "triggers": ["Stress", "Bright lights"],
      "relief": ["Dark room", "Medication"],
      "duration": "4 hours",
    },
    {
      "id": "4",
      "date": "2024-06-16",
      "time": "11:20",
      "level": 3,
      "type": "Aching",
      "location": "Knee",
      "description": "Mild knee pain after exercise",
      "triggers": ["Exercise", "Cold weather"],
      "relief": ["Ice", "Rest"],
      "duration": "30 minutes",
    },
    {
      "id": "5",
      "date": "2024-06-15",
      "time": "20:10",
      "level": 6,
      "type": "Burning",
      "location": "Stomach",
      "description": "Sharp burning sensation",
      "triggers": ["Spicy food"],
      "relief": ["Antacid", "Water"],
      "duration": "1.5 hours",
    },
  ];

  List<Map<String, dynamic>> painTypes = [
    {"label": "Sharp", "value": "Sharp", "icon": Icons.bolt},
    {"label": "Dull ache", "value": "Dull ache", "icon": Icons.blur_on},
    {"label": "Throbbing", "value": "Throbbing", "icon": Icons.graphic_eq},
    {"label": "Burning", "value": "Burning", "icon": Icons.local_fire_department},
    {"label": "Stabbing", "value": "Stabbing", "icon": Icons.arrow_upward},
    {"label": "Cramping", "value": "Cramping", "icon": Icons.compress},
    {"label": "Aching", "value": "Aching", "icon": Icons.waves},
    {"label": "Tingling", "value": "Tingling", "icon": Icons.electrical_services},
  ];

  List<Map<String, dynamic>> bodyLocations = [
    {"label": "Head", "value": "Head"},
    {"label": "Neck", "value": "Neck"},
    {"label": "Shoulders", "value": "Shoulders"},
    {"label": "Upper back", "value": "Upper back"},
    {"label": "Lower back", "value": "Lower back"},
    {"label": "Chest", "value": "Chest"},
    {"label": "Stomach", "value": "Stomach"},
    {"label": "Arms", "value": "Arms"},
    {"label": "Hands", "value": "Hands"},
    {"label": "Hips", "value": "Hips"},
    {"label": "Legs", "value": "Legs"},
    {"label": "Knees", "value": "Knees"},
    {"label": "Feet", "value": "Feet"},
    {"label": "Other", "value": "Other"},
  ];

  List<String> selectedTriggers = [];
  List<String> selectedRelief = [];
  String newTrigger = "";
  String newRelief = "";
  String painDuration = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pain Scale Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showPainHistory();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCurrentPainStatus(),
            _buildPainScale(),
            _buildPainDetailsForm(),
            _buildQuickActions(),
            _buildRecentHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPainStatus() {
    Color painColor = _getPainColor(currentPainLevel);
    String painDescription = _getPainDescription(currentPainLevel);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: painColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: painColor,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            _getPainIcon(currentPainLevel),
            color: painColor,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            "Current Pain Level",
            style: TextStyle(
              fontSize: 14,
              color: painColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$currentPainLevel/10",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: painColor,
            ),
          ),
          Text(
            painDescription,
            style: TextStyle(
              fontSize: 12,
              color: painColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPainScale() {
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
          Text(
            "Select Your Pain Level",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Rate your pain from 0 (no pain) to 10 (worst possible pain)",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 60,
            child: Row(
              children: List.generate(11, (index) {
                bool isSelected = currentPainLevel == index;
                Color levelColor = _getPainColor(index);
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentPainLevel = index;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? levelColor 
                            : levelColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: levelColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$index",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : levelColor,
                            ),
                          ),
                          if (index == 0)
                            Icon(
                              Icons.sentiment_very_satisfied,
                              color: isSelected ? Colors.white : levelColor,
                              size: 12,
                            )
                          else if (index <= 3)
                            Icon(
                              Icons.sentiment_satisfied,
                              color: isSelected ? Colors.white : levelColor,
                              size: 12,
                            )
                          else if (index <= 6)
                            Icon(
                              Icons.sentiment_neutral,
                              color: isSelected ? Colors.white : levelColor,
                              size: 12,
                            )
                          else if (index <= 8)
                            Icon(
                              Icons.sentiment_dissatisfied,
                              color: isSelected ? Colors.white : levelColor,
                              size: 12,
                            )
                          else
                            Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: isSelected ? Colors.white : levelColor,
                              size: 12,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          if (currentPainLevel > 0)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: _getPainColor(currentPainLevel).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: _getPainColor(currentPainLevel),
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      _getPainGuidance(currentPainLevel),
                      style: TextStyle(
                        fontSize: 11,
                        color: _getPainColor(currentPainLevel),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPainDetailsForm() {
    if (currentPainLevel == 0) return Container();
    
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
          Text(
            "Pain Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Pain Type",
                  items: painTypes,
                  value: selectedPainType,
                  onChanged: (value, label) {
                    selectedPainType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: bodyLocations,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Description",
            value: painDescription,
            hint: "Describe your pain in detail",
            onChanged: (value) {
              painDescription = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Duration",
            value: painDuration,
            hint: "How long have you had this pain?",
            onChanged: (value) {
              painDuration = value;
              setState(() {});
            },
          ),
          _buildTriggersSection(),
          _buildReliefSection(),
        ],
      ),
    );
  }

  Widget _buildTriggersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Pain Triggers",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Add trigger",
                value: newTrigger,
                hint: "What might have caused the pain?",
                onChanged: (value) {
                  newTrigger = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: "Add",
              size: bs.sm,
              onPressed: () {
                if (newTrigger.isNotEmpty && !selectedTriggers.contains(newTrigger)) {
                  selectedTriggers.add(newTrigger);
                  newTrigger = "";
                  setState(() {});
                }
              },
            ),
          ],
        ),
        if (selectedTriggers.isNotEmpty)
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: selectedTriggers.map((trigger) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: warningColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      trigger,
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        selectedTriggers.remove(trigger);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: warningColor,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildReliefSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Pain Relief Methods",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Add relief method",
                value: newRelief,
                hint: "What helps with the pain?",
                onChanged: (value) {
                  newRelief = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: "Add",
              size: bs.sm,
              onPressed: () {
                if (newRelief.isNotEmpty && !selectedRelief.contains(newRelief)) {
                  selectedRelief.add(newRelief);
                  newRelief = "";
                  setState(() {});
                }
              },
            ),
          ],
        ),
        if (selectedRelief.isNotEmpty)
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: selectedRelief.map((relief) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.healing,
                      color: successColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      relief,
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        selectedRelief.remove(relief);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: successColor,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildQuickActions() {
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
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Log Pain Entry",
                  icon: Icons.save,
                  size: bs.sm,
                  onPressed: currentPainLevel > 0 ? () => _logPainEntry() : null,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Emergency Help",
                  icon: Icons.emergency,
                  size: bs.sm,
                  onPressed: currentPainLevel >= 8 ? () => _emergencyHelp() : null,
                ),
              ),
            ],
          ),
          if (currentPainLevel >= 8)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Severe pain detected. Consider seeking immediate medical attention.",
                      style: TextStyle(
                        fontSize: 11,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentHistory() {
    List<Map<String, dynamic>> recentEntries = painHistory.take(3).toList();
    
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
              Text(
                "Recent Pain Log",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _showPainHistory(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...recentEntries.map((entry) => _buildHistoryEntry(entry)),
        ],
      ),
    );
  }

  Widget _buildHistoryEntry(Map<String, dynamic> entry) {
    DateTime entryDate = DateTime.parse(entry["date"] as String);
    Color painColor = _getPainColor(entry["level"] as int);
    
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: painColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: painColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${entryDate.dMMMy} at ${entry["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: painColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${entry["level"]}/10",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${entry["type"]} pain in ${entry["location"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                "${entry["duration"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((entry["description"] as String).isNotEmpty)
            Text(
              "${entry["description"]}",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Color _getPainColor(int level) {
    if (level == 0) return successColor;
    if (level <= 3) return infoColor;
    if (level <= 6) return warningColor;
    return dangerColor;
  }

  IconData _getPainIcon(int level) {
    if (level == 0) return Icons.sentiment_very_satisfied;
    if (level <= 3) return Icons.sentiment_satisfied;
    if (level <= 6) return Icons.sentiment_neutral;
    if (level <= 8) return Icons.sentiment_dissatisfied;
    return Icons.sentiment_very_dissatisfied;
  }

  String _getPainDescription(int level) {
    switch (level) {
      case 0: return "No pain - feeling great!";
      case 1: return "Very mild pain - barely noticeable";
      case 2: return "Mild pain - doesn't interfere with activities";
      case 3: return "Moderate pain - noticeable but manageable";
      case 4: return "Moderate pain - interferes with some activities";
      case 5: return "Moderate-severe pain - difficult to ignore";
      case 6: return "Severe pain - significantly affects daily life";
      case 7: return "Very severe pain - dominates your senses";
      case 8: return "Intense severe pain - physical activity limited";
      case 9: return "Excruciating pain - unable to function";
      case 10: return "Unimaginable pain - seek emergency care";
      default: return "Unknown pain level";
    }
  }

  String _getPainGuidance(int level) {
    if (level <= 3) return "Mild pain - monitor and use basic self-care";
    if (level <= 6) return "Moderate pain - consider over-the-counter medication";
    if (level <= 8) return "Severe pain - contact your healthcare provider";
    return "Emergency level pain - seek immediate medical attention";
  }

  void _logPainEntry() {
    if (currentPainLevel == 0) return;
    
    isLogging = true;
    setState(() {});

    // Simulate logging delay
    Future.delayed(Duration(seconds: 1), () {
      painHistory.insert(0, {
        "id": "${painHistory.length + 1}",
        "date": DateTime.now().toIso8601String(),
        "time": TimeOfDay.now().kkmm,
        "level": currentPainLevel,
        "type": selectedPainType.isNotEmpty ? selectedPainType : "Not specified",
        "location": selectedLocation.isNotEmpty ? selectedLocation : "Not specified",
        "description": painDescription,
        "triggers": List.from(selectedTriggers),
        "relief": List.from(selectedRelief),
        "duration": painDuration.isNotEmpty ? painDuration : "Not specified",
      });

      // Reset form
      currentPainLevel = 0;
      selectedPainType = "";
      selectedLocation = "";
      painDescription = "";
      selectedTriggers.clear();
      selectedRelief.clear();
      newTrigger = "";
      newRelief = "";
      painDuration = "";
      
      isLogging = false;
      setState(() {});
      ss("Pain entry logged successfully");
    });
  }

  void _emergencyHelp() {
    si("Emergency help resources accessed");
  }

  void _showPainHistory() {
    si("Showing complete pain history");
  }
}
