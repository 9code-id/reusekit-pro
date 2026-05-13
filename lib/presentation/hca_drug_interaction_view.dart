import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDrugInteractionView extends StatefulWidget {
  const HcaDrugInteractionView({super.key});

  @override
  State<HcaDrugInteractionView> createState() => _HcaDrugInteractionViewState();
}

class _HcaDrugInteractionViewState extends State<HcaDrugInteractionView> {
  List<String> selectedMedications = [];
  String searchQuery = "";
  String riskLevel = "All";
  bool showOnlyInteractions = false;
  
  List<String> riskLevels = ["All", "Minor", "Moderate", "Major", "Critical"];
  
  List<Map<String, dynamic>> commonMedications = [
    "Aspirin", "Warfarin", "Metformin", "Lisinopril", "Simvastatin",
    "Omeprazole", "Amlodipine", "Levothyroxine", "Metoprolol", "Atorvastatin",
    "Losartan", "Hydrochlorothiazide", "Furosemide", "Prednisone", "Gabapentin",
    "Tramadol", "Sertraline", "Fluoxetine", "Amoxicillin", "Ciprofloxacin",
    "Azithromycin", "Digoxin", "Phenytoin", "Carbamazepine", "Lithium",
    "Insulin", "Glipizide", "Clopidogrel", "Diazepam", "Morphine"
  ].map((med) => {"name": med, "category": _getMedicationCategory(med)}).toList();

  List<Map<String, dynamic>> drugInteractions = [
    {
      "id": 1,
      "drug1": "Warfarin",
      "drug2": "Aspirin",
      "riskLevel": "Major",
      "severity": "High",
      "description": "Increased risk of bleeding complications",
      "mechanism": "Additive anticoagulant effects",
      "clinicalEffects": [
        "Increased bleeding risk",
        "Prolonged bleeding time",
        "Risk of hemorrhage"
      ],
      "recommendations": [
        "Monitor INR closely",
        "Consider dose adjustment",
        "Watch for bleeding signs"
      ],
      "alternatives": [
        "Use acetaminophen for pain relief",
        "Consider PPI for GI protection"
      ],
      "color": dangerColor,
      "icon": Icons.dangerous,
      "frequency": "Common",
      "onset": "Rapid (within hours)",
      "references": ["FDA Drug Safety Communication", "Clinical Guidelines"]
    },
    {
      "id": 2,
      "drug1": "Simvastatin",
      "drug2": "Warfarin",
      "riskLevel": "Moderate",
      "severity": "Medium",
      "description": "Potential enhancement of anticoagulant effect",
      "mechanism": "CYP enzyme inhibition",
      "clinicalEffects": [
        "Increased INR",
        "Enhanced anticoagulation",
        "Bleeding risk"
      ],
      "recommendations": [
        "Monitor INR more frequently",
        "Consider warfarin dose reduction",
        "Regular coagulation monitoring"
      ],
      "alternatives": [
        "Switch to rosuvastatin",
        "Use lower statin dose"
      ],
      "color": warningColor,
      "icon": Icons.warning,
      "frequency": "Occasional",
      "onset": "Delayed (days to weeks)",
      "references": ["Pharmacokinetic Studies", "Case Reports"]
    },
    {
      "id": 3,
      "drug1": "Metformin",
      "drug2": "Lisinopril",
      "riskLevel": "Minor",
      "severity": "Low",
      "description": "Generally safe combination, monitor kidney function",
      "mechanism": "Potential renal function effects",
      "clinicalEffects": [
        "Possible lactic acidosis risk",
        "Kidney function changes"
      ],
      "recommendations": [
        "Monitor kidney function",
        "Check for signs of lactic acidosis",
        "Regular lab monitoring"
      ],
      "alternatives": [
        "Continue with monitoring",
        "Alternative ACE inhibitor if needed"
      ],
      "color": successColor,
      "icon": Icons.info,
      "frequency": "Rare",
      "onset": "Variable",
      "references": ["Clinical Studies", "Safety Data"]
    },
    {
      "id": 4,
      "drug1": "Digoxin",
      "drug2": "Furosemide",
      "riskLevel": "Major",
      "severity": "High",
      "description": "Increased risk of digoxin toxicity due to electrolyte changes",
      "mechanism": "Potassium and magnesium depletion",
      "clinicalEffects": [
        "Digoxin toxicity",
        "Cardiac arrhythmias",
        "Electrolyte imbalance"
      ],
      "recommendations": [
        "Monitor electrolytes closely",
        "Check digoxin levels regularly",
        "Monitor cardiac rhythm"
      ],
      "alternatives": [
        "Use potassium-sparing diuretic",
        "Supplement electrolytes"
      ],
      "color": dangerColor,
      "icon": Icons.dangerous,
      "frequency": "Common",
      "onset": "Within days",
      "references": ["Cardiology Guidelines", "FDA Warnings"]
    },
    {
      "id": 5,
      "drug1": "Sertraline",
      "drug2": "Tramadol",
      "riskLevel": "Critical",
      "severity": "Critical",
      "description": "Risk of serotonin syndrome",
      "mechanism": "Serotonergic activity enhancement",
      "clinicalEffects": [
        "Serotonin syndrome",
        "Hyperthermia",
        "Altered mental status",
        "Muscle rigidity"
      ],
      "recommendations": [
        "Avoid combination if possible",
        "Use alternative pain medication",
        "Monitor for serotonin syndrome"
      ],
      "alternatives": [
        "Use acetaminophen or NSAIDs",
        "Consider other antidepressants"
      ],
      "color": Color(0xFF8B0000),
      "icon": Icons.report_problem,
      "frequency": "Significant",
      "onset": "Rapid (hours)",
      "references": ["FDA Black Box Warning", "Emergency Medicine Guidelines"]
    }
  ];

  List<Map<String, dynamic>> get filteredInteractions {
    List<Map<String, dynamic>> filtered = drugInteractions;
    
    if (selectedMedications.isNotEmpty) {
      filtered = filtered.where((interaction) {
        return selectedMedications.contains(interaction["drug1"]) || 
               selectedMedications.contains(interaction["drug2"]);
      }).toList();
    }
    
    if (riskLevel != "All") {
      filtered = filtered.where((interaction) => interaction["riskLevel"] == riskLevel).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drug Interactions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddMedicationModal(),
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _showInteractionGuide(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSelectedMedications(),
            _buildSearchAndFilter(),
            _buildInteractionSummary(),
            _buildInteractionsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedMedications() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medication, color: primaryColor),
              SizedBox(width: spXs),
              Text(
                "Selected Medications (${selectedMedications.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              if (selectedMedications.isNotEmpty)
                GestureDetector(
                  onTap: () => _clearAllMedications(),
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                      color: dangerColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          if (selectedMedications.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: disabledOutlineBorderColor, style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Add medications to check for interactions",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Add First Medication",
                    size: bs.sm,
                    onPressed: () => _showAddMedicationModal(),
                  ),
                ],
              ),
            )
          else
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: selectedMedications.map((med) => _buildMedicationChip(med)).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildMedicationChip(String medication) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.medication,
            size: 16,
            color: primaryColor,
          ),
          SizedBox(width: spXs),
          Text(
            medication,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: () => _removeMedication(medication),
            child: Icon(
              Icons.close,
              size: 16,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search interactions",
          value: searchQuery,
          hint: "Search by drug name or interaction",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Risk Level",
                items: riskLevels.map((level) => {
                  "label": level,
                  "value": level,
                }).toList(),
                value: riskLevel,
                onChanged: (value, label) {
                  riskLevel = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Show only interactions",
                    "value": true,
                    "checked": showOnlyInteractions,
                  }
                ],
                value: [if (showOnlyInteractions) {"label": "Show only interactions", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  showOnlyInteractions = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractionSummary() {
    if (selectedMedications.length < 2) return SizedBox.shrink();

    int majorCount = filteredInteractions.where((i) => i["riskLevel"] == "Major").length;
    int moderateCount = filteredInteractions.where((i) => i["riskLevel"] == "Moderate").length;
    int minorCount = filteredInteractions.where((i) => i["riskLevel"] == "Minor").length;
    int criticalCount = filteredInteractions.where((i) => i["riskLevel"] == "Critical").length;

    Color summaryColor = criticalCount > 0 ? Color(0xFF8B0000) :
                        majorCount > 0 ? dangerColor :
                        moderateCount > 0 ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: summaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: summaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                criticalCount > 0 ? Icons.report_problem :
                majorCount > 0 ? Icons.dangerous :
                moderateCount > 0 ? Icons.warning : Icons.check_circle,
                color: summaryColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Interaction Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: summaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              if (criticalCount > 0) _buildSummaryCard("Critical", "$criticalCount", Color(0xFF8B0000)),
              if (majorCount > 0) _buildSummaryCard("Major", "$majorCount", dangerColor),
              if (moderateCount > 0) _buildSummaryCard("Moderate", "$moderateCount", warningColor),
              if (minorCount > 0) _buildSummaryCard("Minor", "$minorCount", successColor),
              if (criticalCount == 0 && majorCount == 0 && moderateCount == 0 && minorCount == 0)
                _buildSummaryCard("No Interactions", "0", successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionsList() {
    if (selectedMedications.length < 2) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "Add at least 2 medications",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Select medications to check for interactions",
              style: TextStyle(color: disabledColor),
            ),
          ],
        ),
      );
    }

    if (filteredInteractions.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              size: 64,
              color: successColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No interactions found",
              style: TextStyle(
                fontSize: fsH6,
                color: successColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "The selected medications appear to be safe together",
              style: TextStyle(color: disabledColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Drug Interactions (${filteredInteractions.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredInteractions.map((interaction) => _buildInteractionCard(interaction)),
      ],
    );
  }

  Widget _buildInteractionCard(Map<String, dynamic> interaction) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: interaction["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (interaction["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  interaction["icon"] as IconData,
                  color: interaction["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${interaction["drug1"]} + ${interaction["drug2"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (interaction["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            interaction["riskLevel"],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: interaction["color"] as Color,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "• ${interaction["frequency"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${interaction["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Onset: ${interaction["onset"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QButton(
            label: "View Details",
            size: bs.sm,
            onPressed: () => _showInteractionDetails(interaction),
          ),
        ],
      ),
    );
  }

  void _showAddMedicationModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Text(
                    "Add Medication",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QTextField(
                      label: "Search medications",
                      value: searchQuery,
                      hint: "Type medication name",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Common Medications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...commonMedications
                        .where((med) => 
                          searchQuery.isEmpty || 
                          med["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          med["category"].toLowerCase().contains(searchQuery.toLowerCase())
                        )
                        .map((med) => _buildMedicationListItem(med)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationListItem(Map<String, dynamic> medication) {
    bool isSelected = selectedMedications.contains(medication["name"]);

    return GestureDetector(
      onTap: () => _toggleMedication(medication["name"]),
      child: Container(
        margin: EdgeInsets.only(bottom: spXs),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusXs),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.medication,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medication["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primaryColor : Colors.black87,
                    ),
                  ),
                  Text(
                    medication["category"],
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
    );
  }

  void _toggleMedication(String medication) {
    if (selectedMedications.contains(medication)) {
      selectedMedications.remove(medication);
    } else {
      selectedMedications.add(medication);
    }
    setState(() {});
  }

  void _removeMedication(String medication) {
    selectedMedications.remove(medication);
    setState(() {});
  }

  void _clearAllMedications() {
    selectedMedications.clear();
    setState(() {});
  }

  void _showInteractionDetails(Map<String, dynamic> interaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (interaction["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      interaction["icon"] as IconData,
                      color: interaction["color"] as Color,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${interaction["drug1"]} + ${interaction["drug2"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (interaction["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${interaction["riskLevel"]} Risk",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: interaction["color"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              _buildDetailSection("Description", interaction["description"]),
              _buildDetailSection("Mechanism", interaction["mechanism"]),
              _buildDetailSection("Onset", interaction["onset"]),
              _buildDetailSection("Frequency", interaction["frequency"]),
              _buildListSection("Clinical Effects", interaction["clinicalEffects"]),
              _buildListSection("Recommendations", interaction["recommendations"]),
              _buildListSection("Alternatives", interaction["alternatives"]),
              _buildListSection("References", interaction["references"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<dynamic> items) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) => Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showInteractionGuide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Drug Interaction Guide",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              _buildGuideSection("Critical", "Life-threatening interactions requiring immediate medical attention", Color(0xFF8B0000)),
              _buildGuideSection("Major", "Serious interactions that may cause significant harm", dangerColor),
              _buildGuideSection("Moderate", "Interactions requiring careful monitoring and possible dose adjustments", warningColor),
              _buildGuideSection("Minor", "Generally safe combinations with minimal risk", successColor),
              Container(
                margin: EdgeInsets.only(top: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor),
                        SizedBox(width: spXs),
                        Text(
                          "Important Notes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "• This tool is for educational purposes only\n• Always consult healthcare professionals\n• Individual responses may vary\n• Consider timing, dosage, and duration\n• Report any adverse effects immediately",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideSection(String title, String description, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  static String _getMedicationCategory(String medication) {
    Map<String, String> categories = {
      "Aspirin": "Antiplatelet",
      "Warfarin": "Anticoagulant",
      "Metformin": "Antidiabetic",
      "Lisinopril": "ACE Inhibitor",
      "Simvastatin": "Statin",
      "Omeprazole": "PPI",
      "Amlodipine": "Calcium Channel Blocker",
      "Levothyroxine": "Thyroid Hormone",
      "Metoprolol": "Beta Blocker",
      "Atorvastatin": "Statin",
      "Losartan": "ARB",
      "Hydrochlorothiazide": "Diuretic",
      "Furosemide": "Loop Diuretic",
      "Prednisone": "Corticosteroid",
      "Gabapentin": "Anticonvulsant",
      "Tramadol": "Analgesic",
      "Sertraline": "SSRI",
      "Fluoxetine": "SSRI",
      "Amoxicillin": "Antibiotic",
      "Ciprofloxacin": "Antibiotic",
      "Azithromycin": "Antibiotic",
      "Digoxin": "Cardiac Glycoside",
      "Phenytoin": "Anticonvulsant",
      "Carbamazepine": "Anticonvulsant",
      "Lithium": "Mood Stabilizer",
      "Insulin": "Antidiabetic",
      "Glipizide": "Antidiabetic",
      "Clopidogrel": "Antiplatelet",
      "Diazepam": "Benzodiazepine",
      "Morphine": "Opioid",
    };
    return categories[medication] ?? "Other";
  }
}
