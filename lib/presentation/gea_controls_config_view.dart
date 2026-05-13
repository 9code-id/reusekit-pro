import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaControlsConfigView extends StatefulWidget {
  const GeaControlsConfigView({super.key});

  @override
  State<GeaControlsConfigView> createState() => _GeaControlsConfigViewState();
}

class _GeaControlsConfigViewState extends State<GeaControlsConfigView> {
  String selectedControlScheme = "Default";
  Map<String, String> keyBindings = {
    "Move Forward": "W",
    "Move Backward": "S",
    "Move Left": "A",
    "Move Right": "D",
    "Jump": "Space",
    "Crouch": "Ctrl",
    "Run": "Shift",
    "Interact": "E",
    "Attack": "Left Click",
    "Block": "Right Click",
    "Reload": "R",
    "Use Item": "F",
    "Open Inventory": "Tab",
    "Open Map": "M",
    "Open Menu": "Esc",
    "Chat": "Enter",
    "Quick Save": "F5",
    "Quick Load": "F9",
    "Screenshot": "F12",
    "Toggle UI": "H",
  };

  Map<String, String> gamepadBindings = {
    "Move": "Left Stick",
    "Look": "Right Stick",
    "Jump": "A",
    "Crouch": "B",
    "Run": "Left Trigger",
    "Interact": "X",
    "Attack": "Right Trigger",
    "Block": "Left Bumper",
    "Reload": "Y",
    "Use Item": "Right Bumper",
    "Open Inventory": "View",
    "Open Map": "Menu",
    "Quick Actions": "D-Pad",
  };

  // Mouse and Gamepad Settings
  double mouseSensitivity = 50.0;
  double gamepadSensitivity = 50.0;
  bool invertMouseY = false;
  bool invertGamepadY = false;
  double mouseAcceleration = 0.0;
  double gamepadDeadzone = 15.0;
  bool mouseSmoothing = true;
  bool gamepadVibration = true;

  List<Map<String, dynamic>> controlSchemes = [
    {"label": "Default", "value": "Default"},
    {"label": "FPS Shooter", "value": "FPS"},
    {"label": "Racing", "value": "Racing"},
    {"label": "Strategy", "value": "Strategy"},
    {"label": "Custom", "value": "Custom"},
  ];

  String? editingKey;
  bool isWaitingForInput = false;

  void _editKeyBinding(String action) {
    setState(() {
      editingKey = action;
      isWaitingForInput = true;
    });
    si("Press any key to bind to $action");
  }

  void _saveKeyBinding(String action, String key) {
    setState(() {
      keyBindings[action] = key;
      editingKey = null;
      isWaitingForInput = false;
    });
    ss("$action bound to $key");
  }

  void _resetToDefault() async {
    bool isConfirmed = await confirm("Reset all key bindings to default?");
    if (isConfirmed) {
      setState(() {
        keyBindings = {
          "Move Forward": "W",
          "Move Backward": "S",
          "Move Left": "A",
          "Move Right": "D",
          "Jump": "Space",
          "Crouch": "Ctrl",
          "Run": "Shift",
          "Interact": "E",
          "Attack": "Left Click",
          "Block": "Right Click",
          "Reload": "R",
          "Use Item": "F",
          "Open Inventory": "Tab",
          "Open Map": "M",
          "Open Menu": "Esc",
          "Chat": "Enter",
          "Quick Save": "F5",
          "Quick Load": "F9",
          "Screenshot": "F12",
          "Toggle UI": "H",
        };
        selectedControlScheme = "Default";
        mouseSensitivity = 50.0;
        gamepadSensitivity = 50.0;
        invertMouseY = false;
        invertGamepadY = false;
        mouseAcceleration = 0.0;
        gamepadDeadzone = 15.0;
        mouseSmoothing = true;
        gamepadVibration = true;
      });
      ss("Controls reset to default");
    }
  }

  void _loadControlScheme(String scheme) {
    setState(() {
      selectedControlScheme = scheme;
      switch (scheme) {
        case "FPS":
          keyBindings["Move Forward"] = "W";
          keyBindings["Move Backward"] = "S";
          keyBindings["Move Left"] = "A";
          keyBindings["Move Right"] = "D";
          keyBindings["Jump"] = "Space";
          keyBindings["Crouch"] = "C";
          keyBindings["Run"] = "Shift";
          keyBindings["Reload"] = "R";
          break;
        case "Racing":
          keyBindings["Move Forward"] = "Up Arrow";
          keyBindings["Move Backward"] = "Down Arrow";
          keyBindings["Move Left"] = "Left Arrow";
          keyBindings["Move Right"] = "Right Arrow";
          keyBindings["Jump"] = "Space";
          break;
        case "Strategy":
          keyBindings["Move Forward"] = "W";
          keyBindings["Move Backward"] = "S";
          keyBindings["Move Left"] = "A";
          keyBindings["Move Right"] = "D";
          keyBindings["Select All"] = "Ctrl+A";
          break;
      }
    });
    si("Loaded $scheme control scheme");
  }

  Widget _buildSlider({
    required String title,
    required String subtitle,
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0.0,
    double max = 100.0,
    String suffix = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Text(
              "${value.toInt()}$suffix",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
          activeColor: primaryColor,
          inactiveColor: disabledColor,
        ),
      ],
    );
  }

  Widget _buildKeyBindingRow(String action, String key) {
    final isEditing = editingKey == action;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
      decoration: BoxDecoration(
        color: isEditing ? primaryColor.withAlpha(10) : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusSm),
        border: isEditing ? Border.all(color: primaryColor.withAlpha(50)) : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              action,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Text(
                isEditing ? "Press key..." : key,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isEditing ? warningColor : primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            label: isEditing ? "Cancel" : "Edit",
            size: bs.sm,
            onPressed: () {
              if (isEditing) {
                setState(() {
                  editingKey = null;
                  isWaitingForInput = false;
                });
              } else {
                _editKeyBinding(action);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controls Configuration"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetToDefault,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Control Scheme Selection
            Container(
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
                    "Control Scheme",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  QDropdownField(
                    label: "Select Control Scheme",
                    items: controlSchemes,
                    value: selectedControlScheme,
                    onChanged: (value, label) {
                      _loadControlScheme(value);
                    },
                  ),
                  
                  if (selectedControlScheme != "Default")
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Using $selectedControlScheme control scheme. You can customize individual keys below.",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Mouse Settings
            Container(
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
                    "Mouse Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSlider(
                    title: "Mouse Sensitivity",
                    subtitle: "Adjust mouse movement sensitivity",
                    value: mouseSensitivity,
                    onChanged: (value) {
                      mouseSensitivity = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSlider(
                    title: "Mouse Acceleration",
                    subtitle: "Mouse acceleration curve",
                    value: mouseAcceleration,
                    onChanged: (value) {
                      mouseAcceleration = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Invert Mouse Y-Axis",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Invert vertical mouse movement",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: invertMouseY,
                        onChanged: (value) {
                          invertMouseY = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mouse Smoothing",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Smooth mouse movement for precision",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: mouseSmoothing,
                        onChanged: (value) {
                          mouseSmoothing = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Gamepad Settings
            Container(
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
                    "Gamepad Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSlider(
                    title: "Gamepad Sensitivity",
                    subtitle: "Adjust gamepad stick sensitivity",
                    value: gamepadSensitivity,
                    onChanged: (value) {
                      gamepadSensitivity = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSlider(
                    title: "Stick Deadzone",
                    subtitle: "Minimum input required to register movement",
                    value: gamepadDeadzone,
                    onChanged: (value) {
                      gamepadDeadzone = value;
                      setState(() {});
                    },
                    max: 50.0,
                    suffix: "%",
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Invert Gamepad Y-Axis",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Invert vertical gamepad movement",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: invertGamepadY,
                        onChanged: (value) {
                          invertGamepadY = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gamepad Vibration",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Enable haptic feedback",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: gamepadVibration,
                        onChanged: (value) {
                          gamepadVibration = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Keyboard Bindings
            Container(
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
                          "Keyboard Bindings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Reset All",
                        size: bs.sm,
                        onPressed: _resetToDefault,
                      ),
                    ],
                  ),
                  
                  if (isWaitingForInput)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Press any key to bind to $editingKey",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Action",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Key",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 80), // Space for edit button
                      ],
                    ),
                  ),
                  
                  ...keyBindings.entries.map((entry) {
                    return _buildKeyBindingRow(entry.key, entry.value);
                  }),
                ],
              ),
            ),

            // Gamepad Bindings
            Container(
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
                    "Gamepad Bindings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Action",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Button",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  ...gamepadBindings.entries.map((entry) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Text(
                                entry.value,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Control Settings",
                size: bs.md,
                onPressed: () {
                  ss("Control settings saved successfully!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
