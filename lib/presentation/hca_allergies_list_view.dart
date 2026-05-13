import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaAllergiesListView extends StatefulWidget {
  const HcaAllergiesListView({super.key});

  @override
  State<HcaAllergiesListView> createState() => _HcaAllergiesListViewState();
}

class _HcaAllergiesListViewState extends State<HcaAllergiesListView> {
  List<Map<String, dynamic>> allergies = [
    {
      "id": "1",
      "name": "Peanuts",
      "severity": "High",
      "reactions": ["Difficulty breathing", "Hives", "Nausea"],
      "dateAdded": "2024-01-15",
      "lastReaction": "2024-06-05",
      "color": dangerColor,
      "icon": Icons.warning,
    },
    {
      "id": "2",
      "name": "Shellfish",
      "severity": "Medium",
      "reactions": ["Skin rash", "Swelling"],
      "dateAdded": "2024-02-20",
      "lastReaction": "2024-05-12",
      "color": warningColor,
      "icon": Icons.error_outline,
    },
    {
      "id": "3",
      "name": "Penicillin",
      "severity": "High",
      "reactions": ["Severe rash", "Fever", "Joint pain"],
      "dateAdded": "2024-03-10",
      "lastReaction": "2024-04-18",
      "color": dangerColor,
      "icon": Icons.medication,
    },
    {
      "id": "4",
      "name": "Bee Stings",
      "severity": "Low",
      "reactions": ["Swelling", "Redness"],
      "dateAdded": "2024-04-05",
      "lastReaction": "2024-05-30",
      "color": infoColor,
      "icon": Icons.bug_report,
    },
    {
      "id": "5",
      "name": "Latex",
      "severity": "Medium",
      "reactions": ["Contact dermatitis", "Itching"],
      "dateAdded": "2024-05-15",
      "lastReaction": "2024-06-01",
      "color": warningColor,
      "icon": Icons.health_and_safety,
    },
    {
      "id": "6",
      "name": "Dust Mites",
      "severity": "Low",
      "reactions": ["Sneezing", "Runny nose", "Watery eyes"],
      "dateAdded": "2024-06-01",
      "lastReaction": "2024-06-15",
      "color": infoColor,
      "icon": Icons.home,
    },
  ];

  String searchQuery = "";
  String selectedSeverity = "";
  bool showAddAllergyForm = false;

  String newAllergyName = "";
  String newAllergySeverity = "Low";
  List<String> newAllergyReactions = [];
  String newReactionText = "";

  List<Map<String, dynamic>> severityOptions = [
    {"label": "All Severities", "value": ""},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allergies"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showAddAllergyForm = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            _buildAllergiesList(),
            if (showAddAllergyForm) _buildAddAllergyForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search allergies",
            value: searchQuery,
            hint: "Enter allergy name or reaction",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Filter by Severity",
            items: severityOptions,
            value: selectedSeverity,
            onChanged: (value, label) {
              selectedSeverity = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAllergiesList() {
    List<Map<String, dynamic>> filteredAllergies = allergies.where((allergy) {
      bool matchesSearch = searchQuery.isEmpty ||
          (allergy["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (allergy["reactions"] as List).any((reaction) =>
              (reaction as String).toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesSeverity = selectedSeverity.isEmpty ||
          allergy["severity"] == selectedSeverity;
      
      return matchesSearch && matchesSeverity;
    }).toList();

    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Found ${filteredAllergies.length} allergies",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ...filteredAllergies.map((allergy) => _buildAllergyCard(allergy)),
      ],
    );
  }

  Widget _buildAllergyCard(Map<String, dynamic> allergy) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: allergy["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (allergy["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  allergy["icon"] as IconData,
                  color: allergy["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${allergy["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${allergy["severity"]} Severity",
                      style: TextStyle(
                        fontSize: 12,
                        color: allergy["color"] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showAllergyDetails(allergy),
                child: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Common Reactions:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (allergy["reactions"] as List).map((reaction) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (allergy["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$reaction",
                        style: TextStyle(
                          fontSize: 10,
                          color: allergy["color"] as Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Added: ${DateTime.parse(allergy["dateAdded"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Last Reaction: ${DateTime.parse(allergy["lastReaction"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Emergency Info",
                size: bs.sm,
                onPressed: () => _showEmergencyInfo(allergy),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddAllergyForm() {
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
                "Add New Allergy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showAddAllergyForm = false;
                  newAllergyName = "";
                  newAllergySeverity = "Low";
                  newAllergyReactions.clear();
                  newReactionText = "";
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Allergy Name",
            value: newAllergyName,
            hint: "Enter allergy name",
            onChanged: (value) {
              newAllergyName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Severity Level",
            items: [
              {"label": "Low", "value": "Low"},
              {"label": "Medium", "value": "Medium"},
              {"label": "High", "value": "High"},
            ],
            value: newAllergySeverity,
            onChanged: (value, label) {
              newAllergySeverity = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add Reaction",
                  value: newReactionText,
                  hint: "Enter reaction symptom",
                  onChanged: (value) {
                    newReactionText = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: () {
                  if (newReactionText.isNotEmpty) {
                    newAllergyReactions.add(newReactionText);
                    newReactionText = "";
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          if (newAllergyReactions.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Reactions:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: newAllergyReactions.map((reaction) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              reaction,
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () {
                                newAllergyReactions.remove(reaction);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.close,
                                color: primaryColor,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () {
                    showAddAllergyForm = false;
                    newAllergyName = "";
                    newAllergySeverity = "Low";
                    newAllergyReactions.clear();
                    newReactionText = "";
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Allergy",
                  size: bs.sm,
                  onPressed: () {
                    if (newAllergyName.isNotEmpty && newAllergyReactions.isNotEmpty) {
                      _saveNewAllergy();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveNewAllergy() {
    Color severityColor = newAllergySeverity == "High" ? dangerColor :
                         newAllergySeverity == "Medium" ? warningColor : infoColor;
    
    IconData severityIcon = newAllergySeverity == "High" ? Icons.warning :
                           newAllergySeverity == "Medium" ? Icons.error_outline : Icons.info;

    allergies.add({
      "id": "${allergies.length + 1}",
      "name": newAllergyName,
      "severity": newAllergySeverity,
      "reactions": List.from(newAllergyReactions),
      "dateAdded": DateTime.now().toIso8601String(),
      "lastReaction": DateTime.now().toIso8601String(),
      "color": severityColor,
      "icon": severityIcon,
    });

    showAddAllergyForm = false;
    newAllergyName = "";
    newAllergySeverity = "Low";
    newAllergyReactions.clear();
    newReactionText = "";
    
    setState(() {});
    ss("Allergy added successfully");
  }

  void _showAllergyDetails(Map<String, dynamic> allergy) {
    // Show detailed allergy information
    si("Viewing details for ${allergy["name"]}");
  }

  void _showEmergencyInfo(Map<String, dynamic> allergy) {
    // Show emergency information for the allergy
    si("Emergency information for ${allergy["name"]} allergy");
  }
}
