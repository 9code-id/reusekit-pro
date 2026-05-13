import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHearingTestView extends StatefulWidget {
  const HcaHearingTestView({super.key});

  @override
  State<HcaHearingTestView> createState() => _HcaHearingTestViewState();
}

class _HcaHearingTestViewState extends State<HcaHearingTestView> {
  int currentTab = 0;
  String selectedEar = "Left";
  String selectedFrequency = "1000";
  bool testInProgress = false;
  String testResult = "";
  String symptoms = "";
  String selectedSymptom = "Hearing Loss";
  String testHistory = "";

  List<Map<String, dynamic>> earItems = [
    {"label": "Left Ear", "value": "Left"},
    {"label": "Right Ear", "value": "Right"},
    {"label": "Both Ears", "value": "Both"},
  ];

  List<Map<String, dynamic>> frequencyItems = [
    {"label": "500 Hz", "value": "500"},
    {"label": "1000 Hz", "value": "1000"},
    {"label": "2000 Hz", "value": "2000"},
    {"label": "4000 Hz", "value": "4000"},
    {"label": "8000 Hz", "value": "8000"},
  ];

  List<Map<String, dynamic>> symptomItems = [
    {"label": "Hearing Loss", "value": "Hearing Loss"},
    {"label": "Tinnitus", "value": "Tinnitus"},
    {"label": "Ear Pain", "value": "Ear Pain"},
    {"label": "Dizziness", "value": "Dizziness"},
    {"label": "Ear Discharge", "value": "Ear Discharge"},
  ];

  List<Map<String, dynamic>> hearingTests = [
    {
      "id": "1",
      "date": "2024-06-15",
      "type": "Frequency Test",
      "ear": "Both",
      "result": "Normal",
      "score": 85,
      "notes": "Good hearing response across all frequencies",
    },
    {
      "id": "2",
      "date": "2024-06-10",
      "type": "Speech Test",
      "ear": "Left",
      "result": "Mild Loss",
      "score": 72,
      "notes": "Some difficulty with high frequency sounds",
    },
    {
      "id": "3",
      "date": "2024-06-05",
      "type": "Frequency Test",
      "ear": "Right",
      "result": "Normal",
      "score": 88,
      "notes": "Excellent hearing response",
    },
  ];

  List<Map<String, dynamic>> symptomLogs = [
    {
      "id": "1",
      "date": "2024-06-18",
      "time": "14:30",
      "symptom": "Tinnitus",
      "severity": "Moderate",
      "duration": "2 hours",
      "triggers": "Loud music",
      "notes": "Ringing in left ear after concert",
    },
    {
      "id": "2",
      "date": "2024-06-16",
      "time": "09:15",
      "symptom": "Hearing Loss",
      "severity": "Mild",
      "duration": "30 minutes",
      "triggers": "Earwax buildup",
      "notes": "Temporary muffled hearing",
    },
  ];

  List<Map<String, dynamic>> hearingTips = [
    {
      "title": "Protect Your Hearing",
      "description": "Use ear protection in noisy environments",
      "icon": Icons.volume_down,
    },
    {
      "title": "Clean Ears Safely",
      "description": "Avoid cotton swabs, use approved methods only",
      "icon": Icons.cleaning_services,
    },
    {
      "title": "Regular Check-ups",
      "description": "Get hearing tested annually after age 50",
      "icon": Icons.schedule,
    },
  ];

  void _startHearingTest() {
    setState(() {
      testInProgress = true;
    });
    
    // Simulate test duration
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        testInProgress = false;
        testResult = "Test completed. Score: 82/100 - Normal hearing range";
      });
    });
  }

  Color _getResultColor(String result) {
    switch (result) {
      case "Normal":
        return successColor;
      case "Mild Loss":
        return warningColor;
      case "Moderate Loss":
        return infoColor;
      case "Severe Loss":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Mild":
        return successColor;
      case "Moderate":
        return warningColor;
      case "Severe":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Hearing Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Test", icon: Icon(Icons.hearing)),
        Tab(text: "Symptoms", icon: Icon(Icons.report_problem)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildHearingTestTab(),
        _buildSymptomsTab(),
        _buildHistoryTab(),
        _buildTipsTab(),
      ],
      onInit: (tabController) {
        // TabController initialization if needed
      },
    );
  }

  Widget _buildHearingTestTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Test Setup Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.hearing, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Hearing Test Setup",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Select Ear",
                  items: earItems,
                  value: selectedEar,
                  onChanged: (value, label) {
                    selectedEar = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Test Frequency",
                  items: frequencyItems,
                  value: selectedFrequency,
                  onChanged: (value, label) {
                    selectedFrequency = value;
                    setState(() {});
                  },
                ),
                if (testInProgress)
                  Column(
                    children: [
                      SizedBox(height: spSm),
                      CircularProgressIndicator(color: primaryColor),
                      SizedBox(height: spSm),
                      Text(
                        "Testing in progress...",
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                if (testResult.isNotEmpty && !testInProgress)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(top: spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Text(
                      testResult,
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: testInProgress ? "Testing..." : "Start Test",
                    size: bs.md,
                    onPressed: testInProgress ? null : _startHearingTest,
                  ),
                ),
              ],
            ),
          ),

          // Instructions Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Test Instructions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "1. Find a quiet environment\n2. Use headphones for best results\n3. Tap when you hear the tone\n4. Test may take 2-3 minutes",
                  style: TextStyle(
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Volume Test
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Volume Check",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.volume_up, color: primaryColor),
                    Expanded(
                      child: Slider(
                        value: 0.5,
                        onChanged: (value) {
                          setState(() {});
                        },
                        activeColor: primaryColor,
                        inactiveColor: disabledColor,
                      ),
                    ),
                    Icon(Icons.volume_up, color: primaryColor, size: 32),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Test Volume",
                    size: bs.sm,
                    onPressed: () {
                      // Play test tone
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Log Symptoms Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log Hearing Symptoms",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Symptom Type",
                  items: symptomItems,
                  value: selectedSymptom,
                  onChanged: (value, label) {
                    selectedSymptom = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Description",
                  value: symptoms,
                  hint: "Describe your symptoms in detail...",
                  onChanged: (value) {
                    symptoms = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Log Symptom",
                    size: bs.md,
                    onPressed: () {
                      ss("Symptom logged successfully");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Recent Symptoms
          Text(
            "Recent Symptoms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...symptomLogs.map((symptom) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getSeverityColor("${symptom["severity"]}"),
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${symptom["symptom"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getSeverityColor("${symptom["severity"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${symptom["severity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getSeverityColor("${symptom["severity"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${symptom["date"]} at ${symptom["time"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Duration: ${symptom["duration"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  if (symptom["triggers"] != null)
                    Text(
                      "Triggers: ${symptom["triggers"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  if (symptom["notes"] != null)
                    Text(
                      "${symptom["notes"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Test History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...hearingTests.map((test) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
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
                        "${test["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getResultColor("${test["result"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${test["result"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getResultColor("${test["result"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${test["date"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.hearing, color: disabledBoldColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "${test["ear"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Score: ${test["score"]}/100",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 8,
                        child: LinearProgressIndicator(
                          value: (test["score"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getResultColor("${test["result"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (test["notes"] != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${test["notes"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hearing Health Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...hearingTips.map((tip) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      tip["icon"],
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${tip["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${tip["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Emergency Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.emergency, color: dangerColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "When to See a Doctor",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Sudden hearing loss\n• Persistent ear pain\n• Discharge from ear\n• Dizziness with hearing loss\n• Ringing that won't stop",
                  style: TextStyle(
                    color: dangerColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
