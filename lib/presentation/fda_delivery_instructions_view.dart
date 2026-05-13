import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDeliveryInstructionsView extends StatefulWidget {
  const FdaDeliveryInstructionsView({super.key});

  @override
  State<FdaDeliveryInstructionsView> createState() => _FdaDeliveryInstructionsViewState();
}

class _FdaDeliveryInstructionsViewState extends State<FdaDeliveryInstructionsView> {
  String selectedAddressType = "Home";
  String doorInstructions = "";
  String parkingInstructions = "";
  String contactPreference = "call";
  String accessCode = "";
  String additionalNotes = "";
  bool leaveAtDoor = false;
  bool requireSignature = false;
  bool callOnArrival = true;
  bool textOnArrival = false;
  
  List<String> quickInstructions = [
    "Ring doorbell",
    "Knock on door", 
    "Leave at door",
    "Call on arrival",
    "Don't ring bell - baby sleeping",
    "Use back entrance",
    "Meet at lobby",
    "Leave with security",
    "Hand to customer only",
    "Check ID required"
  ];

  List<String> selectedQuickInstructions = [];

  List<Map<String, dynamic>> savedInstructions = [
    {
      "name": "Home - Weekday",
      "instructions": "Ring doorbell and wait. Leave with neighbor if no answer.",
      "address": "Home",
      "usage": 15
    },
    {
      "name": "Office - Lunch",
      "instructions": "Call when arrived. Meet at main entrance.",
      "address": "Work",
      "usage": 8
    },
    {
      "name": "Weekend - Apartment",
      "instructions": "Use access code 1234. Leave at door #5B.",
      "address": "Home",
      "usage": 12
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Instructions"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveInstructions,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAddressTypeSection(),
            _buildQuickInstructionsSection(),
            _buildSavedInstructionsSection(),
            _buildDetailedInstructionsSection(),
            _buildContactPreferencesSection(),
            _buildSpecialOptionsSection(),
            _buildPreviewSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressTypeSection() {
    final addressTypes = ["Home", "Work", "Other"];
    
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
            "Address Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: addressTypes.map((type) {
              final isSelected = selectedAddressType == type;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedAddressType = type;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: type != addressTypes.last ? spXs : 0),
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      type,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInstructionsSection() {
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
            "Quick Instructions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Tap to add common delivery instructions",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: quickInstructions.map((instruction) {
              final isSelected = selectedQuickInstructions.contains(instruction);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedQuickInstructions.remove(instruction);
                  } else {
                    selectedQuickInstructions.add(instruction);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: isSelected ? Border.all(color: primaryColor) : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                      ],
                      Text(
                        instruction,
                        style: TextStyle(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedInstructionsSection() {
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
              Expanded(
                child: Text(
                  "Saved Instructions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Manage",
                size: bs.sm,
                onPressed: () {
                  // navigateTo(ManageSavedInstructionsView())
                },
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: savedInstructions.map((saved) => _buildSavedInstructionCard(saved)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedInstructionCard(Map<String, dynamic> saved) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${saved["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${saved["address"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "${saved["instructions"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "Used ${saved["usage"]} times",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Use",
            size: bs.sm,
            onPressed: () {
              _applySavedInstructions(saved);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedInstructionsSection() {
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
            "Detailed Instructions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Door/Building Instructions",
            value: doorInstructions,
            hint: "e.g., Ring doorbell, use back entrance, apartment 5B",
            onChanged: (value) {
              doorInstructions = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Parking Instructions",
            value: parkingInstructions,
            hint: "e.g., Park in visitor spot, don't block driveway",
            onChanged: (value) {
              parkingInstructions = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Access Code (if needed)",
            value: accessCode,
            hint: "Building/gate access code",
            onChanged: (value) {
              accessCode = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Additional Notes",
            value: additionalNotes,
            hint: "Any other special instructions or notes for the driver",
            onChanged: (value) {
              additionalNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactPreferencesSection() {
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
            "Contact Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Preferred Contact Method",
            items: [
              {"label": "Call me", "value": "call"},
              {"label": "Text message", "value": "text"},
              {"label": "App notification only", "value": "app"},
              {"label": "Don't contact - just deliver", "value": "none"},
            ],
            value: contactPreference,
            onChanged: (value, label) {
              contactPreference = value;
              setState(() {});
            },
          ),
          Column(
            spacing: spXs,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Call when arrived",
                          "value": true,
                          "checked": callOnArrival,
                        }
                      ],
                      value: callOnArrival ? [{"label": "Call when arrived", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        callOnArrival = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Send text when arrived",
                          "value": true,
                          "checked": textOnArrival,
                        }
                      ],
                      value: textOnArrival ? [{"label": "Send text when arrived", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        textOnArrival = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOptionsSection() {
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
            "Special Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Leave at door (contactless)",
                      "value": true,
                      "checked": leaveAtDoor,
                    }
                  ],
                  value: leaveAtDoor ? [{"label": "Leave at door (contactless)", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    leaveAtDoor = values.isNotEmpty;
                    if (leaveAtDoor) {
                      requireSignature = false;
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Require signature",
                      "value": true,
                      "checked": requireSignature,
                    }
                  ],
                  value: requireSignature ? [{"label": "Require signature", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    if (!leaveAtDoor) {
                      requireSignature = values.isNotEmpty;
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
          if (leaveAtDoor && requireSignature)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "You cannot require signature for contactless delivery",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
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

  Widget _buildPreviewSection() {
    final previewText = _generatePreviewText();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.preview, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Instructions Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              previewText.isNotEmpty ? previewText : "No specific instructions provided.",
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Instructions",
            onPressed: _saveInstructions,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Save as Template",
                size: bs.sm,
                onPressed: _saveAsTemplate,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Clear All",
                size: bs.sm,
                onPressed: _clearInstructions,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _generatePreviewText() {
    List<String> instructions = [];
    
    // Add quick instructions
    if (selectedQuickInstructions.isNotEmpty) {
      instructions.addAll(selectedQuickInstructions);
    }
    
    // Add detailed instructions
    if (doorInstructions.isNotEmpty) {
      instructions.add("Door: $doorInstructions");
    }
    
    if (parkingInstructions.isNotEmpty) {
      instructions.add("Parking: $parkingInstructions");
    }
    
    if (accessCode.isNotEmpty) {
      instructions.add("Access code: $accessCode");
    }
    
    // Add contact preferences
    List<String> contactMethods = [];
    if (callOnArrival) contactMethods.add("call");
    if (textOnArrival) contactMethods.add("text");
    
    if (contactMethods.isNotEmpty) {
      instructions.add("Contact on arrival: ${contactMethods.join(" and ")}");
    }
    
    // Add special options
    if (leaveAtDoor) {
      instructions.add("Leave at door (contactless delivery)");
    }
    
    if (requireSignature && !leaveAtDoor) {
      instructions.add("Signature required");
    }
    
    if (additionalNotes.isNotEmpty) {
      instructions.add("Note: $additionalNotes");
    }
    
    return instructions.join(". ");
  }

  void _applySavedInstructions(Map<String, dynamic> saved) {
    // This would parse and apply the saved instructions
    // For demo purposes, just show success message
    ss("Applied saved instructions: ${saved["name"]}");
    
    // Update usage count
    setState(() {
      saved["usage"] = (saved["usage"] as int) + 1;
    });
  }

  void _saveInstructions() {
    final instructions = _generatePreviewText();
    
    if (instructions.isEmpty) {
      sw("Please add some delivery instructions first");
      return;
    }
    
    ss("Delivery instructions saved successfully!");
    // navigateTo(OrderSummaryView())
  }

  void _saveAsTemplate() async {
    final instructions = _generatePreviewText();
    
    if (instructions.isEmpty) {
      sw("Please add some delivery instructions first");
      return;
    }
    
    // Show dialog to name the template
    ss("Instructions saved as new template");
  }

  void _clearInstructions() async {
    bool isConfirmed = await confirm("Are you sure you want to clear all instructions?");
    
    if (isConfirmed) {
      setState(() {
        doorInstructions = "";
        parkingInstructions = "";
        accessCode = "";
        additionalNotes = "";
        selectedQuickInstructions.clear();
        leaveAtDoor = false;
        requireSignature = false;
        callOnArrival = true;
        textOnArrival = false;
        contactPreference = "call";
      });
      
      si("All instructions cleared");
    }
  }
}
