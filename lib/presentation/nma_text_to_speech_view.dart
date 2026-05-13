import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaTextToSpeechView extends StatefulWidget {
  const NmaTextToSpeechView({super.key});

  @override
  State<NmaTextToSpeechView> createState() => _NmaTextToSpeechViewState();
}

class _NmaTextToSpeechViewState extends State<NmaTextToSpeechView> {
  bool isPlaying = false;
  bool isPaused = false;
  double speechRate = 0.5;
  double pitch = 1.0;
  double volume = 0.8;
  int currentPosition = 0;
  int totalDuration = 450; // seconds
  
  String selectedVoice = "Emma (English - US)";
  List<Map<String, dynamic>> availableVoices = [
    {"name": "Emma (English - US)", "language": "en-US", "gender": "Female"},
    {"name": "James (English - US)", "language": "en-US", "gender": "Male"},
    {"name": "Oliver (English - UK)", "language": "en-GB", "gender": "Male"},
    {"name": "Sophia (English - UK)", "language": "en-GB", "gender": "Female"},
    {"name": "Lucas (English - AU)", "language": "en-AU", "gender": "Male"},
    {"name": "Chloe (English - AU)", "language": "en-AU", "gender": "Female"},
    {"name": "Marie (French)", "language": "fr-FR", "gender": "Female"},
    {"name": "Hans (German)", "language": "de-DE", "gender": "Male"},
  ];
  
  String selectedLanguage = "English (US)";
  List<String> languages = [
    "English (US)",
    "English (UK)", 
    "English (AU)",
    "Spanish",
    "French",
    "German",
    "Italian",
    "Japanese",
    "Korean",
    "Mandarin"
  ];
  
  bool autoPlay = false;
  bool highlightText = true;
  bool pauseOnCall = true;
  bool continueInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text to Speech"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showTTSSettings();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Article Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "TECHNOLOGY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "AI Revolution Transforms Global Industries with Unprecedented Speed",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "By Tech Reporter • 2 hours ago",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Reading time: ${(totalDuration / 60).ceil()} min",
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

          // Player Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Progress Bar
                Row(
                  children: [
                    Text(
                      _formatTime(currentPosition),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: (currentPosition / totalDuration).clamp(0.0, 1.0),
                        activeColor: Colors.white,
                        inactiveColor: Colors.white.withAlpha(128),
                        onChanged: (value) {
                          currentPosition = (value * totalDuration).round();
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      _formatTime(totalDuration),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Playback Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Rewind 30s
                    IconButton(
                      icon: Icon(Icons.replay_30),
                      color: Colors.white,
                      iconSize: 32,
                      onPressed: () {
                        currentPosition = (currentPosition - 30).clamp(0, totalDuration);
                        setState(() {});
                        ss("Rewound 30 seconds");
                      },
                    ),

                    // Previous
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      color: Colors.white,
                      iconSize: 32,
                      onPressed: () {
                        // Go to previous article
                        ss("Previous article");
                      },
                    ),

                    // Play/Pause
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          isPlaying 
                            ? (isPaused ? Icons.play_arrow : Icons.pause)
                            : Icons.play_arrow,
                        ),
                        color: primaryColor,
                        iconSize: 40,
                        onPressed: () {
                          if (!isPlaying) {
                            isPlaying = true;
                            isPaused = false;
                            ss("Playback started");
                          } else if (isPaused) {
                            isPaused = false;
                            ss("Playback resumed");
                          } else {
                            isPaused = true;
                            ss("Playback paused");
                          }
                          setState(() {});
                        },
                      ),
                    ),

                    // Next
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      color: Colors.white,
                      iconSize: 32,
                      onPressed: () {
                        // Go to next article
                        ss("Next article");
                      },
                    ),

                    // Forward 30s
                    IconButton(
                      icon: Icon(Icons.forward_30),
                      color: Colors.white,
                      iconSize: 32,
                      onPressed: () {
                        currentPosition = (currentPosition + 30).clamp(0, totalDuration);
                        setState(() {});
                        ss("Forwarded 30 seconds");
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Speed and Voice Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Speed Control
                    GestureDetector(
                      onTap: () {
                        _showSpeedControl();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.speed, color: Colors.white, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${speechRate.toStringAsFixed(1)}x",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Voice Selection
                    GestureDetector(
                      onTap: () {
                        _showVoiceSelection();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.record_voice_over, color: Colors.white, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              selectedVoice.split(" ")[0],
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Volume Control
                    GestureDetector(
                      onTap: () {
                        _showVolumeControl();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              volume > 0.5 ? Icons.volume_up : Icons.volume_down,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(volume * 100).round()}%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Article Content with Highlighting
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHighlightedText(
                    "In a groundbreaking development that promises to reshape industries worldwide, artificial intelligence technology has achieved unprecedented adoption rates across diverse sectors, from healthcare and finance to manufacturing and entertainment.",
                    0,
                    92,
                  ),
                  SizedBox(height: spMd),
                  
                  _buildHighlightedText(
                    "The rapid integration of AI systems has resulted in efficiency gains of up to 300% in some organizations, while simultaneously creating new job categories that didn't exist just five years ago. Companies report significant improvements in decision-making processes, customer service quality, and operational efficiency.",
                    93,
                    185,
                  ),
                  SizedBox(height: spMd),
                  
                  _buildHighlightedText(
                    "Dr. Sarah Chen, Director of the Global AI Research Institute, explains: \"We're witnessing the most significant technological transformation since the internet revolution. The pace of change is extraordinary, and organizations that fail to adapt risk being left behind.\"",
                    186,
                    278,
                  ),
                  SizedBox(height: spMd),
                  
                  _buildHighlightedText(
                    "Key industries experiencing transformation include autonomous vehicles, which are now being tested in over 50 cities worldwide, and medical diagnosis systems that can detect diseases with 99.7% accuracy. Financial institutions have automated 80% of their routine transactions, while educational platforms are providing personalized learning experiences to millions of students globally.",
                    279,
                    450,
                  ),
                ],
              ),
            ),
          ),

          // Bottom Controls
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.bookmark_border),
                  color: primaryColor,
                  onPressed: () {
                    ss("Article bookmarked");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  color: primaryColor,
                  onPressed: () {
                    ss("Article shared");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.download),
                  color: primaryColor,
                  onPressed: () {
                    ss("Audio downloaded");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.playlist_add),
                  color: primaryColor,
                  onPressed: () {
                    ss("Added to playlist");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText(String text, int startWord, int endWord) {
    // Simulate current reading position highlighting
    bool isCurrentlyReading = currentPosition >= startWord && currentPosition <= endWord;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isCurrentlyReading && highlightText && isPlaying ? primaryColor.withAlpha(51) : null,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: primaryColor,
          backgroundColor: isCurrentlyReading && highlightText && isPlaying 
              ? primaryColor.withAlpha(26) 
              : null,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _showSpeedControl() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Playback Speed",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Row(
              children: [
                Text("0.5x"),
                Expanded(
                  child: Slider(
                    value: speechRate,
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    label: "${speechRate.toStringAsFixed(1)}x",
                    onChanged: (value) {
                      speechRate = value;
                      setState(() {});
                    },
                  ),
                ),
                Text("2.0x"),
              ],
            ),
            
            Text(
              "Current speed: ${speechRate.toStringAsFixed(1)}x",
              style: TextStyle(color: disabledBoldColor),
            ),
          ],
        ),
      ),
    );
  }

  void _showVoiceSelection() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Voice",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: availableVoices.length,
                itemBuilder: (context, index) {
                  final voice = availableVoices[index];
                  bool isSelected = selectedVoice == voice["name"];
                  
                  return GestureDetector(
                    onTap: () {
                      selectedVoice = voice["name"]!;
                      setState(() {});
                      Navigator.pop(context);
                      ss("Voice changed to ${voice["name"]}");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(51) : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            voice["gender"] == "Male" ? Icons.face : Icons.face_3,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  voice["name"]!,
                                  style: TextStyle(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${voice["language"]} • ${voice["gender"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check, color: primaryColor),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVolumeControl() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Volume Control",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Row(
              children: [
                Icon(Icons.volume_down),
                Expanded(
                  child: Slider(
                    value: volume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: "${(volume * 100).round()}%",
                    onChanged: (value) {
                      volume = value;
                      setState(() {});
                    },
                  ),
                ),
                Icon(Icons.volume_up),
              ],
            ),
            
            Text(
              "Volume: ${(volume * 100).round()}%",
              style: TextStyle(color: disabledBoldColor),
            ),
          ],
        ),
      ),
    );
  }

  void _showTTSSettings() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Text-to-Speech Settings",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Row(
              children: [
                Icon(Icons.highlight, color: primaryColor),
                SizedBox(width: spSm),
                Text("Highlight Text", style: TextStyle(color: primaryColor)),
                Spacer(),
                Switch(
                  value: highlightText,
                  onChanged: (value) {
                    highlightText = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            Row(
              children: [
                Icon(Icons.play_circle, color: primaryColor),
                SizedBox(width: spSm),
                Text("Auto-play Articles", style: TextStyle(color: primaryColor)),
                Spacer(),
                Switch(
                  value: autoPlay,
                  onChanged: (value) {
                    autoPlay = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            Row(
              children: [
                Icon(Icons.phone, color: primaryColor),
                SizedBox(width: spSm),
                Text("Pause on Call", style: TextStyle(color: primaryColor)),
                Spacer(),
                Switch(
                  value: pauseOnCall,
                  onChanged: (value) {
                    pauseOnCall = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            Row(
              children: [
                Icon(Icons.play_circle_outline, color: primaryColor),
                SizedBox(width: spSm),
                Text("Continue in Background", style: TextStyle(color: primaryColor)),
                Spacer(),
                Switch(
                  value: continueInBackground,
                  onChanged: (value) {
                    continueInBackground = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
