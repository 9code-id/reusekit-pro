import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaLessonPlayerView extends StatefulWidget {
  const ElaLessonPlayerView({super.key});

  @override
  State<ElaLessonPlayerView> createState() => _ElaLessonPlayerViewState();
}

class _ElaLessonPlayerViewState extends State<ElaLessonPlayerView> {
  bool loading = true;
  int currentSectionIndex = 0;
  bool isPlaying = false;
  bool showNotes = false;
  bool showHighlights = false;
  String userNotes = "";
  String selectedText = "";

  Map<String, dynamic> lesson = {
    "id": "lesson_001",
    "title": "Introduction to Character Analysis",
    "currentSection": 2,
    "totalSections": 6,
  };

  List<Map<String, dynamic>> sections = [
    {
      "id": "section_1",
      "title": "What is Character Analysis?",
      "type": "Video",
      "duration": "8 minutes",
      "content": "Welcome to our comprehensive lesson on character analysis! In this section, we'll explore what character analysis means and why it's such an important skill in literature...",
      "videoUrl": "https://picsum.photos/800/450?random=1&keyword=video",
      "isCompleted": true,
    },
    {
      "id": "section_2",
      "title": "Character Traits and Attributes", 
      "type": "Interactive",
      "duration": "12 minutes",
      "content": "Characters in stories have many different traits that make them unique. Let's learn how to identify both physical traits (what they look like) and personality traits (how they act and think)...",
      "interactiveElements": [
        {"type": "highlight", "text": "Physical traits describe appearance"},
        {"type": "highlight", "text": "Personality traits describe behavior"},
      ],
      "isCompleted": true,
    },
    {
      "id": "section_3",
      "title": "Understanding Character Motivations",
      "type": "Reading",
      "duration": "10 minutes", 
      "content": "Every character in a story has reasons for their actions. These reasons are called motivations. Understanding why a character does something helps us better understand the story...\n\nFor example, when Harry Potter chooses to face Voldemort, his motivation comes from his desire to protect his friends and the wizarding world. This motivation reveals his brave and selfless personality.\n\nCharacter motivations can include:\n• Personal goals and desires\n• Fear or anxiety about something\n• Love for family or friends\n• A sense of duty or responsibility\n• Past experiences that shape their decisions",
      "isCompleted": false,
    },
    {
      "id": "section_4",
      "title": "Character Development and Growth",
      "type": "Interactive", 
      "duration": "15 minutes",
      "content": "Characters often change throughout a story. This change is called character development. Let's explore how and why characters grow...",
      "isCompleted": false,
    },
    {
      "id": "section_5",
      "title": "Practice Exercise: Character Analysis",
      "type": "Exercise",
      "duration": "20 minutes",
      "content": "Now it's time to practice! Read the short story excerpt and analyze the main character using the techniques you've learned...",
      "isCompleted": false,
    },
    {
      "id": "section_6",
      "title": "Final Assessment Quiz",
      "type": "Quiz", 
      "duration": "15 minutes",
      "content": "Test your understanding with this comprehensive quiz on character analysis...",
      "isCompleted": false,
    },
  ];

  List<Map<String, dynamic>> userHighlights = [
    {
      "id": "highlight_1",
      "text": "Physical traits describe appearance",
      "note": "Important distinction between physical and personality traits",
      "sectionId": "section_2",
      "color": "yellow",
    },
    {
      "id": "highlight_2", 
      "text": "Character motivations can include personal goals",
      "note": "Key types of motivations to look for",
      "sectionId": "section_3",
      "color": "blue",
    },
  ];

  List<Map<String, dynamic>> bookmarks = [
    {
      "id": "bookmark_1",
      "sectionId": "section_2",
      "title": "Character Traits and Attributes",
      "timestamp": "5:30",
      "note": "Great explanation of trait types",
    },
    {
      "id": "bookmark_2",
      "sectionId": "section_3", 
      "title": "Understanding Character Motivations",
      "timestamp": "3:15",
      "note": "Harry Potter motivation example",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadLessonContent();
  }

  void _loadLessonContent() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  void _nextSection() {
    if (currentSectionIndex < sections.length - 1) {
      currentSectionIndex++;
      setState(() {});
    }
  }

  void _previousSection() {
    if (currentSectionIndex > 0) {
      currentSectionIndex--;
      setState(() {});
    }
  }

  void _markSectionComplete() {
    sections[currentSectionIndex]["isCompleted"] = true;
    setState(() {});
    
    // Auto-advance to next section
    if (currentSectionIndex < sections.length - 1) {
      Future.delayed(Duration(seconds: 1), () {
        _nextSection();
      });
    }
  }

  void _addHighlight(String text) {
    String highlightId = "highlight_${userHighlights.length + 1}";
    userHighlights.add({
      "id": highlightId,
      "text": text,
      "note": "",
      "sectionId": sections[currentSectionIndex]["id"],
      "color": "yellow",
    });
    setState(() {});
    
    ss("Text highlighted successfully!");
  }

  void _addBookmark() {
    String bookmarkId = "bookmark_${bookmarks.length + 1}";
    Map<String, dynamic> currentSection = sections[currentSectionIndex];
    
    bookmarks.add({
      "id": bookmarkId,
      "sectionId": currentSection["id"],
      "title": currentSection["title"],
      "timestamp": "0:00",
      "note": "Bookmarked section",
    });
    setState(() {});
    
    ss("Section bookmarked successfully!");
  }

  void _addNote() {
    if (userNotes.trim().isNotEmpty) {
      // Save note logic here
      ss("Note saved successfully!");
      userNotes = "";
      setState(() {});
    }
  }

  Color _getSectionTypeColor(String type) {
    switch (type) {
      case "Video":
        return primaryColor;
      case "Interactive":
        return warningColor;
      case "Reading":
        return infoColor;
      case "Exercise":
        return successColor;
      case "Quiz":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSectionTypeIcon(String type) {
    switch (type) {
      case "Video":
        return Icons.play_circle;
      case "Interactive":
        return Icons.touch_app;
      case "Reading":
        return Icons.menu_book;
      case "Exercise":
        return Icons.assignment;
      case "Quiz":
        return Icons.quiz;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading Lesson..."),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, dynamic> currentSection = sections[currentSectionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("${lesson["title"]}"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_add),
            onPressed: _addBookmark,
          ),
          IconButton(
            icon: Icon(Icons.note_add),
            onPressed: () {
              showNotes = !showNotes;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.highlight),
            onPressed: () {
              showHighlights = !showHighlights;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: primaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Progress Bar
                Row(
                  children: [
                    Text(
                      "Section ${currentSectionIndex + 1} of ${sections.length}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(((currentSectionIndex + 1) / sections.length) * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (currentSectionIndex + 1) / sections.length,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spXs),
                
                // Section Info
                Row(
                  children: [
                    Icon(
                      _getSectionTypeIcon("${currentSection["type"]}"),
                      size: 16,
                      color: _getSectionTypeColor("${currentSection["type"]}"),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${currentSection["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${currentSection["duration"]}",
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

          // Main Content Area
          Expanded(
            child: Row(
              children: [
                // Content Panel
                Expanded(
                  flex: showNotes || showHighlights ? 2 : 3,
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Video Content (for video sections)
                          if (currentSection["type"] == "Video")
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    child: Image.network(
                                      "${currentSection["videoUrl"]}",
                                      width: double.infinity,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        isPlaying = !isPlaying;
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.9),
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: Icon(
                                          isPlaying ? Icons.pause : Icons.play_arrow,
                                          size: 32,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isPlaying)
                                    Positioned(
                                      bottom: spSm,
                                      left: spSm,
                                      right: spSm,
                                      child: Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 0.4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                          if (currentSection["type"] == "Video")
                            SizedBox(height: spMd),

                          // Text Content
                          SelectableText(
                            "${currentSection["content"]}",
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                              height: 1.6,
                            ),
                            onSelectionChanged: (selection, cause) {
                              if (selection.isValid) {
                                selectedText = "${currentSection["content"]}".substring(
                                  selection.start,
                                  selection.end,
                                );
                              }
                            },
                          ),

                          // Interactive Elements (for interactive sections)
                          if (currentSection.containsKey("interactiveElements"))
                            Column(
                              children: [
                                SizedBox(height: spMd),
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: warningColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    border: Border.all(
                                      color: warningColor.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            color: warningColor,
                                            size: 20,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Interactive Learning",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: warningColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Column(
                                        children: (currentSection["interactiveElements"] as List).map((element) {
                                          return Container(
                                            margin: EdgeInsets.only(bottom: spXs),
                                            padding: EdgeInsets.all(spXs),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.highlight,
                                                  color: successColor,
                                                  size: 16,
                                                ),
                                                SizedBox(width: spXs),
                                                Expanded(
                                                  child: Text(
                                                    "${element["text"]}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.w600,
                                                    ),
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
                              ],
                            ),

                          SizedBox(height: spMd),

                          // Text Selection Actions
                          if (selectedText.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Selected Text:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    selectedText,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      QButton(
                                        label: "Highlight",
                                        size: bs.sm,
                                        onPressed: () => _addHighlight(selectedText),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        label: "Clear",
                                        size: bs.sm,
                                        onPressed: () {
                                          selectedText = "";
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Side Panels
                if (showNotes || showHighlights)
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.05),
                      border: Border(
                        left: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Panel Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              if (showNotes)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      showNotes = true;
                                      showHighlights = false;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: spXs,
                                        horizontal: spSm,
                                      ),
                                      decoration: BoxDecoration(
                                        color: showNotes && !showHighlights
                                            ? primaryColor.withValues(alpha: 0.1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "Notes",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: showNotes && !showHighlights
                                              ? primaryColor
                                              : disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (showHighlights)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      showNotes = false;
                                      showHighlights = true;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: spXs,
                                        horizontal: spSm,
                                      ),
                                      decoration: BoxDecoration(
                                        color: showHighlights && !showNotes
                                            ? primaryColor.withValues(alpha: 0.1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "Highlights",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: showHighlights && !showNotes
                                              ? primaryColor
                                              : disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              IconButton(
                                icon: Icon(Icons.close),
                                iconSize: 20,
                                onPressed: () {
                                  showNotes = false;
                                  showHighlights = false;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),

                        // Panel Content
                        Expanded(
                          child: showNotes
                              ? _buildNotesPanel()
                              : _buildHighlightsPanel(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Navigation Controls
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                QButton(
                  label: "Previous",
                  icon: Icons.arrow_back,
                  size: bs.sm,
                  onPressed: currentSectionIndex > 0 ? _previousSection : null,
                ),
                Spacer(),
                if (!currentSection["isCompleted"])
                  QButton(
                    label: "Mark Complete",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: _markSectionComplete,
                  ),
                SizedBox(width: spSm),
                QButton(
                  label: currentSectionIndex < sections.length - 1 ? "Next" : "Finish",
                  icon: currentSectionIndex < sections.length - 1 
                      ? Icons.arrow_forward 
                      : Icons.check_circle,
                  size: bs.sm,
                  onPressed: _nextSection,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesPanel() {
    return Padding(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          // Add Note
          QMemoField(
            label: "Add your notes...",
            value: userNotes,
            hint: "Write your thoughts about this section",
            onChanged: (value) {
              userNotes = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Note",
              size: bs.sm,
              onPressed: _addNote,
            ),
          ),
          SizedBox(height: spMd),

          // Notes List
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Previous Notes",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "No notes yet for this lesson.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsPanel() {
    return Padding(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Highlights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Expanded(
            child: userHighlights.isEmpty
                ? Center(
                    child: Text(
                      "No highlights yet.\nSelect text and tap 'Highlight' to add.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: userHighlights.length,
                    itemBuilder: (context, index) {
                      final highlight = userHighlights[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.yellow.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              color: Colors.yellow,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${highlight["text"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (highlight["note"].isNotEmpty)
                              Column(
                                children: [
                                  SizedBox(height: spXs),
                                  Text(
                                    "${highlight["note"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
