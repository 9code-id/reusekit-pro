import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDietaryPreferencesView extends StatefulWidget {
  const FdaDietaryPreferencesView({super.key});

  @override
  State<FdaDietaryPreferencesView> createState() => _FdaDietaryPreferencesViewState();
}

class _FdaDietaryPreferencesViewState extends State<FdaDietaryPreferencesView> {
  List<String> selectedDiets = ["Vegetarian"];
  List<String> selectedRestrictions = ["No Pork"];
  List<String> selectedIntolerances = ["Lactose Intolerant"];
  int currentTab = 0;
  String customRestriction = "";
  bool enableNotifications = true;
  bool strictMode = false;

  final List<Map<String, dynamic>> dietTypes = [
    {
      "name": "Vegetarian",
      "description": "No meat, poultry, or fish",
      "icon": Icons.eco,
      "color": Colors.green,
    },
    {
      "name": "Vegan",
      "description": "No animal products at all",
      "icon": Icons.local_florist,
      "color": Colors.green[700],
    },
    {
      "name": "Pescatarian",
      "description": "Fish allowed, no meat or poultry",
      "icon": Icons.set_meal,
      "color": Colors.blue,
    },
    {
      "name": "Keto",
      "description": "Low carb, high fat diet",
      "icon": Icons.fitness_center,
      "color": Colors.orange,
    },
    {
      "name": "Paleo",
      "description": "Stone age diet principles",
      "icon": Icons.nature,
      "color": Colors.brown,
    },
    {
      "name": "Mediterranean",
      "description": "Mediterranean diet style",
      "icon": Icons.restaurant,
      "color": Colors.teal,
    },
  ];

  final List<Map<String, dynamic>> restrictions = [
    {
      "name": "No Pork",
      "description": "Avoid pork and pork products",
      "icon": Icons.block,
    },
    {
      "name": "No Beef",
      "description": "Avoid beef and beef products",
      "icon": Icons.block,
    },
    {
      "name": "No Seafood",
      "description": "Avoid all seafood and fish",
      "icon": Icons.block,
    },
    {
      "name": "No Alcohol",
      "description": "Avoid alcohol in cooking",
      "icon": Icons.no_drinks,
    },
    {
      "name": "Halal Only",
      "description": "Only halal certified food",
      "icon": Icons.verified,
    },
    {
      "name": "Kosher Only",
      "description": "Only kosher certified food",
      "icon": Icons.verified,
    },
  ];

  final List<Map<String, dynamic>> intolerances = [
    {
      "name": "Lactose Intolerant",
      "description": "Cannot digest dairy products",
      "severity": "High",
      "color": Colors.red,
    },
    {
      "name": "Gluten Intolerant",
      "description": "Cannot consume gluten",
      "severity": "High",
      "color": Colors.red,
    },
    {
      "name": "Nut Allergy",
      "description": "Allergic to tree nuts",
      "severity": "Severe",
      "color": Colors.red[800],
    },
    {
      "name": "Soy Intolerant",
      "description": "Cannot consume soy products",
      "severity": "Medium",
      "color": Colors.orange,
    },
    {
      "name": "Egg Allergy",
      "description": "Allergic to eggs",
      "severity": "Medium",
      "color": Colors.orange,
    },
    {
      "name": "Shellfish Allergy",
      "description": "Allergic to shellfish",
      "severity": "Severe",
      "color": Colors.red[800],
    },
  ];

  Widget _buildDietTypesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Your Diet Type",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Choose the diet that best describes your eating habits",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...dietTypes.map((diet) => _buildDietCard(diet)),
          SizedBox(height: spLg),
          _buildSettingsSection(),
        ],
      ),
    );
  }

  Widget _buildDietCard(Map<String, dynamic> diet) {
    bool isSelected = selectedDiets.contains(diet["name"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: () {
            if (isSelected) {
              selectedDiets.remove(diet["name"]);
            } else {
              selectedDiets.add(diet["name"]);
            }
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (diet["color"] as Color).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    diet["icon"],
                    color: diet["color"],
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        diet["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        diet["description"],
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: primaryColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestrictionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Food Restrictions",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Select foods you want to avoid",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ...restrictions.map((restriction) => _buildRestrictionCard(restriction)),
          SizedBox(height: spMd),
          _buildCustomRestrictionSection(),
        ],
      ),
    );
  }

  Widget _buildRestrictionCard(Map<String, dynamic> restriction) {
    bool isSelected = selectedRestrictions.contains(restriction["name"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isSelected ? dangerColor.withAlpha(20) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isSelected ? dangerColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: () {
            if (isSelected) {
              selectedRestrictions.remove(restriction["name"]);
            } else {
              selectedRestrictions.add(restriction["name"]);
            }
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    restriction["icon"],
                    color: dangerColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restriction["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        restriction["description"],
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: dangerColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntolerancesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Allergies & Intolerances",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Important: Select all allergies and intolerances for your safety",
            style: TextStyle(
              color: dangerColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spMd),
          ...intolerances.map((intolerance) => _buildIntoleranceCard(intolerance)),
        ],
      ),
    );
  }

  Widget _buildIntoleranceCard(Map<String, dynamic> intolerance) {
    bool isSelected = selectedIntolerances.contains(intolerance["name"]);
    Color severityColor = intolerance["color"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isSelected ? severityColor.withAlpha(20) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isSelected ? severityColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: () {
            if (isSelected) {
              selectedIntolerances.remove(intolerance["name"]);
            } else {
              selectedIntolerances.add(intolerance["name"]);
            }
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: severityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.warning,
                    color: severityColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            intolerance["name"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: severityColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              intolerance["severity"],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        intolerance["description"],
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: severityColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomRestrictionSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Custom Restriction",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Add custom food restriction",
            value: customRestriction,
            hint: "e.g., No onions, No spicy food",
            onChanged: (value) {
              customRestriction = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Add Restriction",
            size: bs.sm,
            onPressed: customRestriction.isEmpty ? null : () {
              if (!selectedRestrictions.contains(customRestriction)) {
                selectedRestrictions.add(customRestriction);
                customRestriction = "";
                setState(() {});
                ss("Custom restriction added");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preference Settings",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dietary Notifications",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Get alerts for dietary conflicts",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: enableNotifications,
                onChanged: (value) {
                  enableNotifications = value;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Strict Mode",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Hide all non-compliant foods",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: strictMode,
                onChanged: (value) {
                  strictMode = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dietary Preferences",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Diet Types", icon: Icon(Icons.restaurant_menu)),
        Tab(text: "Restrictions", icon: Icon(Icons.block)),
        Tab(text: "Allergies", icon: Icon(Icons.warning)),
      ],
      tabChildren: [
        _buildDietTypesTab(),
        _buildRestrictionsTab(),
        _buildIntolerancesTab(),
      ],
    );
  }
}
