import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGameSettingsView extends StatefulWidget {
  const GeaGameSettingsView({super.key});

  @override
  State<GeaGameSettingsView> createState() => _GeaGameSettingsViewState();
}

class _GeaGameSettingsViewState extends State<GeaGameSettingsView> {
  // Graphics Settings
  String resolutionMode = "1920x1080";
  String displayMode = "Fullscreen";
  String graphicsQuality = "High";
  double brightnessLevel = 75.0;
  double contrastLevel = 50.0;
  double saturationLevel = 50.0;
  bool vsyncEnabled = true;
  bool antiAliasingEnabled = true;
  bool shadowsEnabled = true;
  String textureQuality = "High";
  String effectsQuality = "Medium";
  int frameRateLimit = 60;

  // Audio Settings
  double masterVolume = 80.0;
  double musicVolume = 70.0;
  double effectsVolume = 85.0;
  double voiceVolume = 90.0;
  bool spatialAudioEnabled = true;
  String audioDevice = "Default";
  String audioQuality = "High";

  // Gameplay Settings
  String difficulty = "Normal";
  bool autoSaveEnabled = true;
  int autoSaveInterval = 5;
  bool tutorialEnabled = true;
  bool subtitlesEnabled = false;
  String language = "English";
  bool showDamageNumbers = true;
  bool showMinimap = true;
  double mouseSensitivity = 50.0;
  bool invertMouseY = false;

  // Performance Settings
  String performanceMode = "Balanced";
  bool dynamicResolutionEnabled = false;
  bool lowLatencyModeEnabled = false;
  int maxFrameRate = 60;
  String renderScale = "100%";

  // Notification Settings
  bool achievementNotifications = true;
  bool friendNotifications = true;
  bool gameInvites = true;
  bool updateNotifications = true;

  List<Map<String, dynamic>> resolutionOptions = [
    {"label": "1920x1080 (Full HD)", "value": "1920x1080"},
    {"label": "2560x1440 (2K)", "value": "2560x1440"},
    {"label": "3840x2160 (4K)", "value": "3840x2160"},
    {"label": "1366x768", "value": "1366x768"},
    {"label": "1600x900", "value": "1600x900"},
  ];

  List<Map<String, dynamic>> displayModeOptions = [
    {"label": "Fullscreen", "value": "Fullscreen"},
    {"label": "Windowed", "value": "Windowed"},
    {"label": "Borderless Window", "value": "Borderless"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Ultra", "value": "Ultra"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> difficultyOptions = [
    {"label": "Easy", "value": "Easy"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Hard", "value": "Hard"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Japanese", "value": "Japanese"},
    {"label": "Korean", "value": "Korean"},
    {"label": "Chinese", "value": "Chinese"},
  ];

  void _saveSettings() {
    ss("Settings saved successfully!");
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all settings to default values?");
    if (isConfirmed) {
      setState(() {
        // Reset to default values
        resolutionMode = "1920x1080";
        displayMode = "Fullscreen";
        graphicsQuality = "High";
        brightnessLevel = 75.0;
        contrastLevel = 50.0;
        saturationLevel = 50.0;
        vsyncEnabled = true;
        antiAliasingEnabled = true;
        shadowsEnabled = true;
        textureQuality = "High";
        effectsQuality = "Medium";
        frameRateLimit = 60;
        
        masterVolume = 80.0;
        musicVolume = 70.0;
        effectsVolume = 85.0;
        voiceVolume = 90.0;
        spatialAudioEnabled = true;
        audioDevice = "Default";
        audioQuality = "High";
        
        difficulty = "Normal";
        autoSaveEnabled = true;
        autoSaveInterval = 5;
        tutorialEnabled = true;
        subtitlesEnabled = false;
        language = "English";
        showDamageNumbers = true;
        showMinimap = true;
        mouseSensitivity = 50.0;
        invertMouseY = false;
        
        performanceMode = "Balanced";
        dynamicResolutionEnabled = false;
        lowLatencyModeEnabled = false;
        maxFrameRate = 60;
        renderScale = "100%";
        
        achievementNotifications = true;
        friendNotifications = true;
        gameInvites = true;
        updateNotifications = true;
      });
      ss("Settings reset to default values");
    }
  }

  Widget _buildSlider({
    required String title,
    required String subtitle,
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0.0,
    double max = 100.0,
    int divisions = 100,
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
          divisions: divisions,
          onChanged: onChanged,
          activeColor: primaryColor,
          inactiveColor: disabledColor,
        ),
      ],
    );
  }

  Widget _buildSwitchSetting({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
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
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdownSetting({
    required String title,
    required String subtitle,
    required String value,
    required List<Map<String, dynamic>> items,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
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
        QDropdownField(
          label: "",
          items: items,
          value: value,
          onChanged: (newValue, label) => onChanged(newValue),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetToDefaults,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Graphics Settings
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
                    "Graphics Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildDropdownSetting(
                    title: "Resolution",
                    subtitle: "Display resolution for the game",
                    value: resolutionMode,
                    items: resolutionOptions,
                    onChanged: (value) {
                      resolutionMode = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildDropdownSetting(
                    title: "Display Mode",
                    subtitle: "How the game window is displayed",
                    value: displayMode,
                    items: displayModeOptions,
                    onChanged: (value) {
                      displayMode = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildDropdownSetting(
                    title: "Graphics Quality",
                    subtitle: "Overall graphics quality preset",
                    value: graphicsQuality,
                    items: qualityOptions,
                    onChanged: (value) {
                      graphicsQuality = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSlider(
                    title: "Brightness",
                    subtitle: "Adjust screen brightness",
                    value: brightnessLevel,
                    onChanged: (value) {
                      brightnessLevel = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSlider(
                    title: "Contrast",
                    subtitle: "Adjust image contrast",
                    value: contrastLevel,
                    onChanged: (value) {
                      contrastLevel = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSwitchSetting(
                    title: "V-Sync",
                    subtitle: "Synchronize frame rate with monitor refresh rate",
                    value: vsyncEnabled,
                    onChanged: (value) {
                      vsyncEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Anti-Aliasing",
                    subtitle: "Smooth jagged edges in graphics",
                    value: antiAliasingEnabled,
                    onChanged: (value) {
                      antiAliasingEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Shadows",
                    subtitle: "Enable dynamic shadows",
                    value: shadowsEnabled,
                    onChanged: (value) {
                      shadowsEnabled = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Audio Settings
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
                    "Audio Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSlider(
                    title: "Master Volume",
                    subtitle: "Overall game volume",
                    value: masterVolume,
                    onChanged: (value) {
                      masterVolume = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSlider(
                    title: "Music Volume",
                    subtitle: "Background music volume",
                    value: musicVolume,
                    onChanged: (value) {
                      musicVolume = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSlider(
                    title: "Sound Effects Volume",
                    subtitle: "Game sound effects volume",
                    value: effectsVolume,
                    onChanged: (value) {
                      effectsVolume = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSlider(
                    title: "Voice Volume",
                    subtitle: "Character voice and dialogue volume",
                    value: voiceVolume,
                    onChanged: (value) {
                      voiceVolume = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSwitchSetting(
                    title: "Spatial Audio",
                    subtitle: "3D positional audio effects",
                    value: spatialAudioEnabled,
                    onChanged: (value) {
                      spatialAudioEnabled = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Gameplay Settings
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
                    "Gameplay Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildDropdownSetting(
                    title: "Difficulty",
                    subtitle: "Game difficulty level",
                    value: difficulty,
                    items: difficultyOptions,
                    onChanged: (value) {
                      difficulty = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildDropdownSetting(
                    title: "Language",
                    subtitle: "Interface and audio language",
                    value: language,
                    items: languageOptions,
                    onChanged: (value) {
                      language = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSlider(
                    title: "Mouse Sensitivity",
                    subtitle: "Mouse cursor sensitivity",
                    value: mouseSensitivity,
                    onChanged: (value) {
                      mouseSensitivity = value;
                      setState(() {});
                    },
                    suffix: "%",
                  ),
                  
                  _buildSwitchSetting(
                    title: "Auto Save",
                    subtitle: "Automatically save game progress",
                    value: autoSaveEnabled,
                    onChanged: (value) {
                      autoSaveEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Tutorial",
                    subtitle: "Show tutorial and help messages",
                    value: tutorialEnabled,
                    onChanged: (value) {
                      tutorialEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Subtitles",
                    subtitle: "Show text subtitles for audio",
                    value: subtitlesEnabled,
                    onChanged: (value) {
                      subtitlesEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Show Damage Numbers",
                    subtitle: "Display damage numbers during combat",
                    value: showDamageNumbers,
                    onChanged: (value) {
                      showDamageNumbers = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Show Minimap",
                    subtitle: "Display minimap on screen",
                    value: showMinimap,
                    onChanged: (value) {
                      showMinimap = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Invert Mouse Y-Axis",
                    subtitle: "Invert vertical mouse movement",
                    value: invertMouseY,
                    onChanged: (value) {
                      invertMouseY = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Performance Settings
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
                    "Performance Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSlider(
                    title: "Max Frame Rate",
                    subtitle: "Maximum frames per second",
                    value: maxFrameRate.toDouble(),
                    min: 30,
                    max: 144,
                    divisions: 114,
                    onChanged: (value) {
                      maxFrameRate = value.toInt();
                      setState(() {});
                    },
                    suffix: " FPS",
                  ),
                  
                  _buildSwitchSetting(
                    title: "Dynamic Resolution",
                    subtitle: "Automatically adjust resolution for performance",
                    value: dynamicResolutionEnabled,
                    onChanged: (value) {
                      dynamicResolutionEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Low Latency Mode",
                    subtitle: "Reduce input lag for competitive gaming",
                    value: lowLatencyModeEnabled,
                    onChanged: (value) {
                      lowLatencyModeEnabled = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Notification Settings
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
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSwitchSetting(
                    title: "Achievement Notifications",
                    subtitle: "Show notifications when achievements are unlocked",
                    value: achievementNotifications,
                    onChanged: (value) {
                      achievementNotifications = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Friend Notifications",
                    subtitle: "Show notifications when friends come online",
                    value: friendNotifications,
                    onChanged: (value) {
                      friendNotifications = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Game Invites",
                    subtitle: "Allow friends to send game invitations",
                    value: gameInvites,
                    onChanged: (value) {
                      gameInvites = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildSwitchSetting(
                    title: "Update Notifications",
                    subtitle: "Notify when game updates are available",
                    value: updateNotifications,
                    onChanged: (value) {
                      updateNotifications = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              width: double.infinity,
              child: Column(
                spacing: spSm,
                children: [
                  QButton(
                    label: "Save Settings",
                    size: bs.md,
                    onPressed: _saveSettings,
                  ),
                  QButton(
                    label: "Reset to Defaults",
                    size: bs.md,
                    onPressed: _resetToDefaults,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
