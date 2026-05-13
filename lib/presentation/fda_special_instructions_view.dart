import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaSpecialInstructionsView extends StatefulWidget {
  const FdaSpecialInstructionsView({super.key});

  @override
  State<FdaSpecialInstructionsView> createState() => _FdaSpecialInstructionsViewState();
}

class _FdaSpecialInstructionsViewState extends State<FdaSpecialInstructionsView> {
  String specialInstructions = "";
  String deliveryInstructions = "";
  String allergyNotes = "";
  String spiceLevel = "Medium";
  String cookingPreference = "Normal";
  String packagingRequest = "Regular";
  bool noOnions = false;
  bool extraCheese = false;
  bool lessOil = false;
  bool extraSpicy = false;
  bool wellCooked = false;

  List<Map<String, dynamic>> spiceLevels = [
    {"label": "Mild", "value": "Mild"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Hot", "value": "Hot"},
    {"label": "Extra Hot", "value": "Extra Hot"},
  ];

  List<Map<String, dynamic>> cookingOptions = [
    {"label": "Normal", "value": "Normal"},
    {"label": "Well Done", "value": "Well Done"},
    {"label": "Medium Rare", "value": "Medium Rare"},
    {"label": "Less Cooked", "value": "Less Cooked"},
  ];

  List<Map<String, dynamic>> packagingOptions = [
    {"label": "Regular", "value": "Regular"},
    {"label": "Eco-Friendly", "value": "Eco-Friendly"},
    {"label": "Extra Secure", "value": "Extra Secure"},
    {"label": "Gift Wrap", "value": "Gift Wrap"},
  ];

  List<Map<String, dynamic>> commonInstructions = [
    {
      "icon": Icons.timer,
      "title": "Ring the doorbell",
      "subtitle": "Please ring doorbell on arrival",
      "selected": false,
    },
    {
      "icon": Icons.phone,
      "title": "Call before delivery",
      "subtitle": "Call 5 minutes before arrival",
      "selected": false,
    },
    {
      "icon": Icons.location_on,
      "title": "Leave at door",
      "subtitle": "Safe contactless delivery",
      "selected": false,
    },
    {
      "icon": Icons.security,
      "title": "Meet at security",
      "subtitle": "Hand over to security guard",
      "selected": false,
    },
    {
      "icon": Icons.elevator,
      "title": "Take elevator",
      "subtitle": "Use main elevator to reach floor",
      "selected": false,
    },
    {
      "icon": Icons.stairs,
      "title": "Use stairs",
      "subtitle": "Elevator not working, use stairs",
      "selected": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Instructions"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              _saveInstructions();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Preferences
            _buildSectionCard(
              title: "Food Preferences",
              icon: Icons.restaurant,
              children: [
                QDropdownField(
                  label: "Spice Level",
                  items: spiceLevels,
                  value: spiceLevel,
                  onChanged: (value, label) {
                    spiceLevel = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Cooking Preference",
                  items: cookingOptions,
                  value: cookingPreference,
                  onChanged: (value, label) {
                    cookingPreference = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Packaging Request",
                  items: packagingOptions,
                  value: packagingRequest,
                  onChanged: (value, label) {
                    packagingRequest = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Food Modifications
            _buildSectionCard(
              title: "Food Modifications",
              icon: Icons.edit,
              children: [
                _buildCheckboxOption("No Onions", noOnions, (value) {
                  noOnions = value;
                  setState(() {});
                }),
                _buildCheckboxOption("Extra Cheese", extraCheese, (value) {
                  extraCheese = value;
                  setState(() {});
                }),
                _buildCheckboxOption("Less Oil", lessOil, (value) {
                  lessOil = value;
                  setState(() {});
                }),
                _buildCheckboxOption("Extra Spicy", extraSpicy, (value) {
                  extraSpicy = value;
                  setState(() {});
                }),
                _buildCheckboxOption("Well Cooked", wellCooked, (value) {
                  wellCooked = value;
                  setState(() {});
                }),
              ],
            ),

            // Delivery Instructions
            _buildSectionCard(
              title: "Delivery Instructions",
              icon: Icons.delivery_dining,
              children: [
                Text(
                  "Select common instructions:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...commonInstructions.map((instruction) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              instruction["selected"] = !instruction["selected"];
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: instruction["selected"] ? primaryColor.withAlpha(20) : Colors.grey[50],
                                border: Border.all(
                                  color: instruction["selected"] ? primaryColor : disabledOutlineBorderColor,
                                ),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    instruction["icon"],
                                    color: instruction["selected"] ? primaryColor : disabledBoldColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${instruction["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: instruction["selected"] ? primaryColor : Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "${instruction["subtitle"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    instruction["selected"] ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: instruction["selected"] ? primaryColor : disabledBoldColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Custom Delivery Instructions",
                  value: deliveryInstructions,
                  hint: "Enter specific delivery instructions like gate code, landmark, etc.",
                  onChanged: (value) {
                    deliveryInstructions = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Special Notes
            _buildSectionCard(
              title: "Special Notes",
              icon: Icons.note,
              children: [
                QMemoField(
                  label: "Special Food Instructions",
                  value: specialInstructions,
                  hint: "Any special requests for food preparation...",
                  onChanged: (value) {
                    specialInstructions = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Allergy Information",
                  value: allergyNotes,
                  hint: "Please mention any food allergies or dietary restrictions...",
                  onChanged: (value) {
                    allergyNotes = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Action Buttons
            Container(
              width: double.infinity,
              child: Column(
                spacing: spSm,
                children: [
                  QButton(
                    label: "Save Instructions",
                    onPressed: () {
                      _saveInstructions();
                    },
                  ),
                  QButton(
                    label: "Clear All",
                    color: dangerColor,
                    onPressed: () {
                      _clearAllInstructions();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
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
              Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...children,
        ],
      ),
    );
  }

  Widget _buildCheckboxOption(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: value ? primaryColor : Colors.transparent,
              border: Border.all(
                color: value ? primaryColor : disabledOutlineBorderColor,
              ),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              Icons.check,
              color: value ? Colors.white : Colors.transparent,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _saveInstructions() {
    // Collect selected common instructions
    List<String> selectedInstructions = commonInstructions
        .where((instruction) => instruction["selected"])
        .map((instruction) => instruction["title"] as String)
        .toList();

    // Show success message
    ss("Special instructions saved successfully");
    
    // Navigate back or to next screen
    // ss('Next page'));
  }

  void _clearAllInstructions() {
    specialInstructions = "";
    deliveryInstructions = "";
    allergyNotes = "";
    spiceLevel = "Medium";
    cookingPreference = "Normal";
    packagingRequest = "Regular";
    noOnions = false;
    extraCheese = false;
    lessOil = false;
    extraSpicy = false;
    wellCooked = false;
    
    for (var instruction in commonInstructions) {
      instruction["selected"] = false;
    }
    
    setState(() {});
    si("All instructions cleared");
  }
}
