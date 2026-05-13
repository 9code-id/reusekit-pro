import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDietaryRestrictionsView extends StatefulWidget {
  const HcaDietaryRestrictionsView({super.key});

  @override
  State<HcaDietaryRestrictionsView> createState() => _HcaDietaryRestrictionsViewState();
}

class _HcaDietaryRestrictionsViewState extends State<HcaDietaryRestrictionsView> {
  int selectedTab = 0;
  String selectedSeverity = "High";
  String searchQuery = "";
  
  List<Map<String, dynamic>> myRestrictions = [
    {
      "id": 1,
      "name": "Gluten Intolerance",
      "type": "Intolerance",
      "severity": "High",
      "description": "Avoid all wheat, barley, rye and related grains",
      "dateAdded": "2024-01-15",
      "symptoms": ["Bloating", "Abdominal pain", "Diarrhea"],
      "alternativeFoods": ["Rice", "Quinoa", "Gluten-free oats"],
      "isActive": true,
      "icon": Icons.grain,
      "color": dangerColor
    },
    {
      "id": 2,
      "name": "Lactose Intolerance",
      "type": "Intolerance",
      "severity": "Medium",
      "description": "Limited dairy products consumption",
      "dateAdded": "2024-01-10",
      "symptoms": ["Gas", "Bloating", "Stomach cramps"],
      "alternativeFoods": ["Almond milk", "Lactose-free dairy", "Coconut milk"],
      "isActive": true,
      "icon": Icons.local_drink,
      "color": warningColor
    },
    {
      "id": 3,
      "name": "Tree Nut Allergy",
      "type": "Allergy",
      "severity": "High",
      "description": "Severe allergic reaction to tree nuts",
      "dateAdded": "2024-01-05",
      "symptoms": ["Hives", "Swelling", "Difficulty breathing"],
      "alternativeFoods": ["Sunflower seeds", "Pumpkin seeds", "Soy nuts"],
      "isActive": true,
      "icon": Icons.warning,
      "color": dangerColor
    }
  ];

  List<Map<String, dynamic>> commonRestrictions = [
    {
      "name": "Shellfish Allergy",
      "type": "Allergy",
      "severity": "High",
      "description": "Allergic reaction to crustaceans and mollusks",
      "icon": Icons.set_meal,
      "category": "Seafood"
    },
    {
      "name": "Peanut Allergy",
      "type": "Allergy", 
      "severity": "High",
      "description": "Severe allergic reaction to peanuts",
      "icon": Icons.warning,
      "category": "Nuts"
    },
    {
      "name": "Vegetarian",
      "type": "Preference",
      "severity": "Medium",
      "description": "No meat, poultry, or fish consumption",
      "icon": Icons.eco,
      "category": "Lifestyle"
    },
    {
      "name": "Vegan",
      "type": "Preference",
      "severity": "High",
      "description": "No animal products including dairy and eggs",
      "icon": Icons.eco,
      "category": "Lifestyle"
    },
    {
      "name": "Low Sodium",
      "type": "Medical",
      "severity": "Medium",
      "description": "Restricted sodium intake for blood pressure",
      "icon": Icons.local_hospital,
      "category": "Medical"
    },
    {
      "name": "Diabetic Diet",
      "type": "Medical",
      "severity": "High", 
      "description": "Low sugar and controlled carbohydrate intake",
      "icon": Icons.monitor_heart,
      "category": "Medical"
    },
    {
      "name": "Keto Diet",
      "type": "Preference",
      "severity": "Medium",
      "description": "Very low carb, high fat diet",
      "icon": Icons.fitness_center,
      "category": "Lifestyle"
    },
    {
      "name": "Low FODMAP",
      "type": "Medical",
      "severity": "Medium",
      "description": "For irritable bowel syndrome management",
      "icon": Icons.healing,
      "category": "Medical"
    }
  ];

  List<Map<String, dynamic>> foodAlternatives = [
    {
      "category": "Gluten-Free Grains",
      "foods": ["Rice", "Quinoa", "Amaranth", "Buckwheat", "Millet"],
      "icon": Icons.grain,
      "color": primaryColor
    },
    {
      "category": "Dairy Alternatives",
      "foods": ["Almond milk", "Oat milk", "Coconut milk", "Soy milk"],
      "icon": Icons.local_drink,
      "color": infoColor
    },
    {
      "category": "Protein Sources",
      "foods": ["Tofu", "Tempeh", "Legumes", "Seeds", "Lean meats"],
      "icon": Icons.fitness_center,
      "color": successColor
    },
    {
      "category": "Sweetener Alternatives",
      "foods": ["Stevia", "Monk fruit", "Erythritol", "Xylitol"],
      "icon": Icons.local_cafe,
      "color": warningColor
    }
  ];

  List<Map<String, dynamic>> emergencyContacts = [
    {
      "name": "Dr. Sarah Johnson",
      "specialty": "Allergist",
      "phone": "+1 (555) 123-4567",
      "available": "24/7 Emergency",
      "icon": Icons.local_hospital
    },
    {
      "name": "Poison Control Center",
      "specialty": "Emergency Response",
      "phone": "+1 (800) 222-1222",
      "available": "24/7",
      "icon": Icons.emergency
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dietary Restrictions",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "My Restrictions", icon: Icon(Icons.warning)),
        Tab(text: "Add New", icon: Icon(Icons.add)),
        Tab(text: "Alternatives", icon: Icon(Icons.swap_horiz)),
        Tab(text: "Emergency", icon: Icon(Icons.emergency)),
      ],
      tabChildren: [
        _buildMyRestrictionsTab(),
        _buildAddNewTab(),
        _buildAlternativesTab(),
        _buildEmergencyTab(),
      ],
    );
  }

  Widget _buildMyRestrictionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(),
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search restrictions",
                  value: searchQuery,
                  hint: "Search by name or type",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: IconButton(
                  icon: Icon(Icons.filter_list, color: primaryColor),
                  onPressed: () => _showFilterDialog(),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Active Restrictions (${myRestrictions.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: myRestrictions
                .where((restriction) => 
                    restriction["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                    restriction["type"].toString().toLowerCase().contains(searchQuery.toLowerCase()))
                .map((restriction) => _buildRestrictionCard(restriction))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    int highSeverity = myRestrictions.where((r) => r["severity"] == "High").length;
    int mediumSeverity = myRestrictions.where((r) => r["severity"] == "Medium").length;
    int lowSeverity = myRestrictions.where((r) => r["severity"] == "Low").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(80)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shield,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dietary Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${myRestrictions.length} active restrictions",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildSeverityCount("High", highSeverity, dangerColor.withAlpha(150)),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSeverityCount("Medium", mediumSeverity, warningColor.withAlpha(150)),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSeverityCount("Low", lowSeverity, successColor.withAlpha(150)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityCount(String severity, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            severity,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestrictionCard(Map<String, dynamic> restriction) {
    Color severityColor = _getSeverityColor(restriction["severity"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: severityColor.withAlpha(50)),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: severityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    restriction["icon"] as IconData,
                    color: severityColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${restriction["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          _buildRestrictionBadge(restriction["type"] as String, primaryColor),
                          SizedBox(width: spSm),
                          _buildRestrictionBadge(restriction["severity"] as String, severityColor),
                        ],
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: restriction["isActive"] as bool,
                  onChanged: (value) => _toggleRestriction(restriction, value),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "${restriction["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            SizedBox(height: spMd),
            _buildInfoSection("Common Symptoms", restriction["symptoms"] as List),
            SizedBox(height: spSm),
            _buildInfoSection("Alternative Foods", restriction["alternativeFoods"] as List),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Added: ${restriction["dateAdded"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () => _editRestriction(restriction),
                  child: Text("Edit"),
                ),
                TextButton(
                  onPressed: () => _deleteRestriction(restriction),
                  style: TextButton.styleFrom(foregroundColor: dangerColor),
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestrictionBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: items.map((item) => Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Text(
              "$item",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildAddNewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(80)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add New Restriction",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Choose from common restrictions or create custom",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Custom Restriction",
                  icon: Icons.create,
                  size: bs.sm,
                  onPressed: () => _showAddCustomDialog(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import from File",
                  icon: Icons.file_upload,
                  size: bs.sm,
                  onPressed: () => _importFromFile(),
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Common Restrictions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: commonRestrictions.map((restriction) => 
              _buildCommonRestrictionCard(restriction)
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCommonRestrictionCard(Map<String, dynamic> restriction) {
    bool isAdded = myRestrictions.any((r) => r["name"] == restriction["name"]);
    Color severityColor = _getSeverityColor(restriction["severity"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isAdded ? Border.all(color: successColor, width: 2) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: severityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    restriction["icon"] as IconData,
                    color: severityColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${restriction["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                _buildRestrictionBadge(restriction["type"] as String, primaryColor),
                SizedBox(width: spSm),
                _buildRestrictionBadge(restriction["category"] as String, infoColor),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${restriction["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: isAdded ? "Already Added" : "Add Restriction",
                size: bs.sm,
                onPressed: isAdded ? null : () => _addCommonRestriction(restriction),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [infoColor, infoColor.withAlpha(80)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Food Alternatives",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Safe alternatives for your dietary restrictions",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),
          Column(
            children: foodAlternatives.map((category) => _buildAlternativeCategory(category)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeCategory(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (category["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    category["icon"] as IconData,
                    color: category["color"] as Color,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Text(
                    "${category["category"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: (category["foods"] as List).map((food) => Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: (category["color"] as Color).withAlpha(30)),
                ),
                child: Text(
                  "$food",
                  style: TextStyle(
                    fontSize: 14,
                    color: category["color"] as Color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [dangerColor, dangerColor.withAlpha(80)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emergency,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emergency Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Important contacts and allergy information",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),
          _buildEmergencyActions(),
          SizedBox(height: spLg),
          Text(
            "Emergency Contacts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: emergencyContacts.map((contact) => _buildEmergencyContact(contact)).toList(),
          ),
          SizedBox(height: spLg),
          _buildAllergyCard(),
        ],
      ),
    );
  }

  Widget _buildEmergencyActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Emergency Actions",
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
                child: QButton(
                  label: "Call 911",
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () => _callEmergency(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share Card",
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () => _shareEmergencyCard(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              contact["icon"] as IconData,
              color: dangerColor,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${contact["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${contact["specialty"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${contact["phone"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${contact["available"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.phone,
            size: bs.sm,
            onPressed: () => _callContact(contact),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergyCard() {
    var severeAllergies = myRestrictions.where((r) => 
        r["type"] == "Allergy" && r["severity"] == "High").toList();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: dangerColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Severe Allergies",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (severeAllergies.isEmpty)
            Text(
              "No severe allergies recorded",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            )
          else
            Column(
              children: severeAllergies.map((allergy) => 
                Padding(
                  padding: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${allergy["name"]} - ${allergy["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ).toList(),
            ),
          SizedBox(height: spMd),
          QButton(
            label: "Generate Emergency Card",
            icon: Icons.credit_card,
            size: bs.sm,
            onPressed: () => _generateEmergencyCard(),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Restrictions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Severity",
              items: [
                {"label": "All", "value": "All"},
                {"label": "High", "value": "High"},
                {"label": "Medium", "value": "Medium"},
                {"label": "Low", "value": "Low"},
              ],
              value: selectedSeverity,
              onChanged: (value, label) {
                selectedSeverity = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _showAddCustomDialog() {
    String restrictionName = "";
    String restrictionType = "Allergy";
    String restrictionSeverity = "Medium";
    String description = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Custom Restriction"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Restriction Name",
                value: restrictionName,
                onChanged: (value) => restrictionName = value,
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Type",
                items: [
                  {"label": "Allergy", "value": "Allergy"},
                  {"label": "Intolerance", "value": "Intolerance"},
                  {"label": "Medical", "value": "Medical"},
                  {"label": "Preference", "value": "Preference"},
                ],
                value: restrictionType,
                onChanged: (value, label) => restrictionType = value,
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Severity",
                items: [
                  {"label": "High", "value": "High"},
                  {"label": "Medium", "value": "Medium"},
                  {"label": "Low", "value": "Low"},
                ],
                value: restrictionSeverity,
                onChanged: (value, label) => restrictionSeverity = value,
              ),
              SizedBox(height: spMd),
              QMemoField(
                label: "Description",
                value: description,
                onChanged: (value) => description = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (restrictionName.isNotEmpty && description.isNotEmpty) {
                _addCustomRestriction(restrictionName, restrictionType, restrictionSeverity, description);
                Navigator.pop(context);
              } else {
                se("Please fill in all required fields");
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _toggleRestriction(Map<String, dynamic> restriction, bool value) {
    setState(() {
      restriction["isActive"] = value;
    });
    ss(value ? "Restriction activated" : "Restriction deactivated");
  }

  void _editRestriction(Map<String, dynamic> restriction) {
    ss("Edit restriction functionality for ${restriction["name"]}");
  }

  void _deleteRestriction(Map<String, dynamic> restriction) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this dietary restriction?");
    if (isConfirmed) {
      setState(() {
        myRestrictions.removeWhere((r) => r["id"] == restriction["id"]);
      });
      ss("Restriction deleted successfully");
    }
  }

  void _addCommonRestriction(Map<String, dynamic> restriction) {
    setState(() {
      myRestrictions.add({
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": restriction["name"],
        "type": restriction["type"],
        "severity": restriction["severity"],
        "description": restriction["description"],
        "dateAdded": DateTime.now().toString().substring(0, 10),
        "symptoms": <String>[],
        "alternativeFoods": <String>[],
        "isActive": true,
        "icon": restriction["icon"],
        "color": _getSeverityColor(restriction["severity"] as String),
      });
    });
    ss("${restriction["name"]} added to your restrictions");
  }

  void _addCustomRestriction(String name, String type, String severity, String description) {
    setState(() {
      myRestrictions.add({
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": name,
        "type": type,
        "severity": severity,
        "description": description,
        "dateAdded": DateTime.now().toString().substring(0, 10),
        "symptoms": <String>[],
        "alternativeFoods": <String>[],
        "isActive": true,
        "icon": Icons.warning,
        "color": _getSeverityColor(severity),
      });
    });
    ss("Custom restriction added successfully");
  }

  void _importFromFile() {
    ss("Import from file functionality");
  }

  void _callEmergency() {
    ss("Calling emergency services...");
  }

  void _shareEmergencyCard() {
    ss("Emergency card shared successfully");
  }

  void _callContact(Map<String, dynamic> contact) {
    ss("Calling ${contact["name"]}...");
  }

  void _generateEmergencyCard() {
    ss("Emergency card generated and saved to device");
  }
}
