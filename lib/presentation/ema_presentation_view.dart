import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPresentationView extends StatefulWidget {
  const EmaPresentationView({super.key});

  @override
  State<EmaPresentationView> createState() => _EmaPresentationViewState();
}

class _EmaPresentationViewState extends State<EmaPresentationView> {
  int currentSlide = 1;
  bool isFullScreen = false;
  bool showNotes = false;
  bool isPlaying = true;
  double progress = 0.35;
  
  Map<String, dynamic> presentationData = {
    "id": "presentation_001",
    "title": "The Future of Artificial Intelligence in Healthcare",
    "speaker": {
      "name": "Dr. Sarah Johnson",
      "title": "Chief Technology Officer",
      "company": "MedTech Solutions",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=doctor",
    },
    "description": "Comprehensive overview of AI applications in modern healthcare, covering diagnostic tools, treatment optimization, and patient care innovations.",
    "duration": "45 minutes",
    "totalSlides": 24,
    "category": "Healthcare Technology",
    "level": "Intermediate",
    "attendees": 1850,
    "startTime": "14:00",
    "currentTime": "14:15",
    "isLive": true,
    "slides": [
      {
        "id": 1,
        "title": "Welcome to AI in Healthcare",
        "type": "title",
        "image": "https://picsum.photos/800/450?random=1&keyword=ai",
        "notes": "Introduction slide covering the scope and importance of AI in modern healthcare systems.",
      },
      {
        "id": 2,
        "title": "Current Healthcare Challenges",
        "type": "content",
        "image": "https://picsum.photos/800/450?random=2&keyword=healthcare",
        "notes": "Discussion of major challenges facing healthcare today: cost, accessibility, accuracy, and efficiency.",
      },
      {
        "id": 3,
        "title": "AI Solutions Overview",
        "type": "content",
        "image": "https://picsum.photos/800/450?random=3&keyword=technology",
        "notes": "Overview of various AI technologies being applied in healthcare settings.",
      },
      {
        "id": 4,
        "title": "Diagnostic AI Applications",
        "type": "content",
        "image": "https://picsum.photos/800/450?random=4&keyword=medical",
        "notes": "Deep dive into AI-powered diagnostic tools including imaging analysis and pattern recognition.",
      },
      {
        "id": 5,
        "title": "Treatment Optimization",
        "type": "content",
        "image": "https://picsum.photos/800/450?random=5&keyword=treatment",
        "notes": "How AI is being used to personalize treatment plans and improve patient outcomes.",
      },
    ],
    "resources": [
      {
        "name": "Full Presentation Slides",
        "type": "pdf",
        "size": "15.2 MB",
        "url": "https://example.com/slides.pdf"
      },
      {
        "name": "Research References",
        "type": "pdf", 
        "size": "3.8 MB",
        "url": "https://example.com/references.pdf"
      },
      {
        "name": "Code Examples",
        "type": "zip",
        "size": "2.1 MB",
        "url": "https://example.com/code.zip"
      },
    ],
    "chapters": [
      {
        "name": "Introduction",
        "startTime": "00:00",
        "slides": [1, 2],
      },
      {
        "name": "Current Challenges",
        "startTime": "05:30",
        "slides": [3, 4, 5],
      },
      {
        "name": "AI Solutions",
        "startTime": "12:45",
        "slides": [6, 7, 8, 9],
      },
      {
        "name": "Implementation",
        "startTime": "25:20",
        "slides": [10, 11, 12],
      },
      {
        "name": "Future Outlook",
        "startTime": "35:15",
        "slides": [13, 14, 15],
      },
    ],
  };

  void _nextSlide() {
    if (currentSlide < (presentationData["totalSlides"] as int)) {
      currentSlide++;
      setState(() {});
    }
  }

  void _previousSlide() {
    if (currentSlide > 1) {
      currentSlide--;
      setState(() {});
    }
  }

  void _goToSlide(int slideNumber) {
    currentSlide = slideNumber;
    setState(() {});
  }

  void _toggleFullScreen() {
    isFullScreen = !isFullScreen;
    setState(() {});
  }

  void _togglePlayPause() {
    isPlaying = !isPlaying;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen ? null : AppBar(
        title: Text("Presentation"),
        actions: [
          GestureDetector(
            onTap: () {
              //navigateTo presentation settings
            },
            child: Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: isFullScreen ? _buildFullScreenView() : _buildNormalView(),
    );
  }

  Widget _buildNormalView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Presentation Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
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
                    if (presentationData["isLive"]) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "LIVE",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${presentationData["attendees"]} watching",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${presentationData["title"]}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${presentationData["description"]}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(220),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${presentationData["speaker"]["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${presentationData["speaker"]["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${presentationData["speaker"]["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Main Slide Display
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Stack(
              children: [
                // Slide Content
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/800/450?random=$currentSlide&keyword=presentation"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Controls Overlay
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  right: spMd,
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(180),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        // Progress Bar
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        // Control Buttons
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _previousSlide,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.skip_previous,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: _togglePlayPause,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: _nextSlide,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "$currentSlide / ${presentationData["totalSlides"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spMd),
                            GestureDetector(
                              onTap: () {
                                showNotes = !showNotes;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: showNotes ? primaryColor : Colors.white.withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notes,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: _toggleFullScreen,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Speaker Notes (if shown)
          if (showNotes) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notes, color: infoColor, size: 20),
                      SizedBox(width: spMd),
                      Text(
                        "Speaker Notes - Slide $currentSlide",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Introduction slide covering the scope and importance of AI in modern healthcare systems. This presentation will explore current challenges, available solutions, and future opportunities in the field.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
          ],

          // Slide Thumbnails
          Text(
            "Slides Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          QHorizontalScroll(
            children: List.generate((presentationData["totalSlides"] as int), (index) {
              int slideNum = index + 1;
              bool isCurrentSlide = slideNum == currentSlide;
              
              return GestureDetector(
                onTap: () => _goToSlide(slideNum),
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spMd),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isCurrentSlide ? primaryColor : disabledOutlineBorderColor,
                      width: isCurrentSlide ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          image: DecorationImage(
                            image: NetworkImage("https://picsum.photos/200/150?random=$slideNum&keyword=slide"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Text(
                          "$slideNum",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isCurrentSlide ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: spLg),

          // Presentation Chapters
          Text(
            "Chapters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...(presentationData["chapters"] as List).map((chapter) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
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
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    Icons.play_circle,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${chapter["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Start time: ${chapter["startTime"]} • ${(chapter["slides"] as List).length} slides",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _goToSlide((chapter["slides"] as List).first);
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          )).toList(),

          SizedBox(height: spLg),

          // Download Resources
          Text(
            "Resources",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...(presentationData["resources"] as List).map((resource) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  resource["type"] == "pdf" ? Icons.picture_as_pdf : 
                  resource["type"] == "zip" ? Icons.archive : Icons.file_download,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${resource["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${resource["size"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Download",
                  size: bs.sm,
                  onPressed: () {
                    ss("Downloading ${resource["name"]}");
                  },
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildFullScreenView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          // Full Screen Slide
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/800/450?random=$currentSlide&keyword=presentation"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Full Screen Controls
          Positioned(
            bottom: spLg,
            left: spLg,
            right: spLg,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(200),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _previousSlide,
                    child: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spLg),
                  GestureDetector(
                    onTap: _togglePlayPause,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spLg),
                  GestureDetector(
                    onTap: _nextSlide,
                    child: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "$currentSlide / ${presentationData["totalSlides"]}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: spLg),
                  GestureDetector(
                    onTap: _toggleFullScreen,
                    child: Icon(
                      Icons.fullscreen_exit,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
