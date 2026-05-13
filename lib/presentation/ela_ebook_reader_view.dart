import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaEbookReaderView extends StatefulWidget {
  const ElaEbookReaderView({super.key});

  @override
  State<ElaEbookReaderView> createState() => _ElaEbookReaderViewState();
}

class _ElaEbookReaderViewState extends State<ElaEbookReaderView> {
  double fontSize = 16.0;
  double lineHeight = 1.5;
  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  bool isNightMode = false;
  bool showControls = true;
  int currentPage = 1;
  int totalPages = 376;
  double readingProgress = 0.15;
  bool isBookmarked = false;
  bool showBookmarks = false;
  bool showNotes = false;

  final Map<String, dynamic> book = {
    "title": "To Kill a Mockingbird",
    "author": "Harper Lee",
    "chapter": "Chapter 1",
    "progress": 15,
  };

  final List<Map<String, dynamic>> bookmarks = [
    {
      "page": 23,
      "chapter": "Chapter 1",
      "note": "Introduction of Scout Finch",
      "date": "2024-03-15",
    },
    {
      "page": 45,
      "chapter": "Chapter 2", 
      "note": "First day of school",
      "date": "2024-03-16",
    },
    {
      "page": 87,
      "chapter": "Chapter 4",
      "note": "Boo Radley mystery begins",
      "date": "2024-03-17",
    },
  ];

  final List<Map<String, dynamic>> notes = [
    {
      "page": 34,
      "text": "Important character development",
      "highlight": "Scout learns about empathy",
      "date": "2024-03-15",
      "color": "yellow",
    },
    {
      "page": 67,
      "text": "Key theme: Social inequality",
      "highlight": "The Cunninghams and social class",
      "date": "2024-03-16", 
      "color": "blue",
    },
  ];

  final String sampleText = """
Chapter 1

When I was almost six and Jem was nearly ten, our father, Atticus Finch, heard us. He was a lawyer. He was nearly fifty. When Jem and I asked him why he was so old, he said he got started late, which we felt reflected upon his abilities and manliness. He was much older than the parents of our school contemporaries, and there was nothing Jem or I could say about him when our classmates said, "My father—"

Jem was football crazy. Atticus was never too tired to play keep-up, but when Jem wanted to tackle him Atticus would say, "I'm too old for that, son."

Our father didn't do anything. He worked in an office, not in a drugstore. Atticus did not drive a dump-truck for the county, he was not the sheriff, he did not farm, work in a garage, or do anything that could possibly arouse the admiration of anyone.

Besides that, he wore glasses. He was nearly blind in his left eye, and said left eyes were the tribal curse of the Finches. Whenever he wanted to see something well, he turned his head and looked from his right eye.

He was not a young man, but Uncle Jack was. Uncle Jack Finch was Atticus's younger brother, and had studied medicine at Boston University; he lived in a small town some twenty miles east of Finch's Landing. We called him Uncle Jack, and he was the only relative we ever saw. He would tell us exactly how we were related to nearly everyone in Maycomb County, and why we shouldn't, which was usually on the grounds of cousinship.

But I never figured out how he could tell us exactly how we were related to nearly everybody in Maycomb County, and at the same time tell us why we shouldn't be proud of our ancestry.

Every summer we had Uncle Jack with us. Every summer Dill came to us.""";

  void _toggleControls() {
    showControls = !showControls;
    setState(() {});
  }

  void _adjustFontSize(double delta) {
    fontSize = (fontSize + delta).clamp(12.0, 24.0);
    setState(() {});
  }

  void _toggleNightMode() {
    isNightMode = !isNightMode;
    if (isNightMode) {
      backgroundColor = Color(0xFF1A1A1A);
      textColor = Color(0xFFE0E0E0);
    } else {
      backgroundColor = Colors.white;
      textColor = Colors.black;
    }
    setState(() {});
  }

  void _nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      readingProgress = currentPage / totalPages;
      setState(() {});
    }
  }

  void _previousPage() {
    if (currentPage > 1) {
      currentPage--;
      readingProgress = currentPage / totalPages;
      setState(() {});
    }
  }

  void _addBookmark() {
    isBookmarked = true;
    setState(() {});
    ss("Bookmark added for page $currentPage");
  }

  void _removeBookmark() {
    isBookmarked = false;
    setState(() {});
    si("Bookmark removed from page $currentPage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: showControls ? AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${book["title"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              "${book["chapter"]} • Page $currentPage of $totalPages",
              style: TextStyle(
                fontSize: 12,
                color: textColor.withAlpha(150),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            color: textColor,
            onPressed: () {
              showBookmarks = true;
              showNotes = false;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.note),
            color: textColor,
            onPressed: () {
              showNotes = true;
              showBookmarks = false;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: textColor,
            onPressed: () {
              _showReaderSettings();
            },
          ),
        ],
      ) : null,
      body: Stack(
        children: [
          // Main Reading Area
          GestureDetector(
            onTap: _toggleControls,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
              padding: EdgeInsets.all(spMd),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showControls) SizedBox(height: 80),
                    
                    Text(
                      sampleText,
                      style: TextStyle(
                        fontSize: fontSize,
                        height: lineHeight,
                        color: textColor,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          // Progress Bar
          if (showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: backgroundColor,
                padding: EdgeInsets.all(spSm),
                child: Column(
                  children: [
                    // Progress Indicator
                    Row(
                      children: [
                        Text(
                          "${(readingProgress * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor.withAlpha(150),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: readingProgress,
                            backgroundColor: textColor.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "$currentPage / $totalPages",
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Navigation Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.skip_previous),
                          color: currentPage > 1 ? textColor : textColor.withAlpha(100),
                          onPressed: currentPage > 1 ? _previousPage : null,
                        ),
                        IconButton(
                          icon: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? primaryColor : textColor,
                          ),
                          onPressed: isBookmarked ? _removeBookmark : _addBookmark,
                        ),
                        IconButton(
                          icon: Icon(Icons.text_fields),
                          color: textColor,
                          onPressed: () => _showReaderSettings(),
                        ),
                        IconButton(
                          icon: Icon(isNightMode ? Icons.light_mode : Icons.dark_mode),
                          color: textColor,
                          onPressed: _toggleNightMode,
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next),
                          color: currentPage < totalPages ? textColor : textColor.withAlpha(100),
                          onPressed: currentPage < totalPages ? _nextPage : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Bookmarks Panel
          if (showBookmarks)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 300,
                color: backgroundColor,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: textColor.withAlpha(50)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Bookmarks",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.close),
                            color: textColor,
                            onPressed: () {
                              showBookmarks = false;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(spSm),
                        itemCount: bookmarks.length,
                        itemBuilder: (context, index) {
                          final bookmark = bookmarks[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: primaryColor.withAlpha(50)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Page ${bookmark["page"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${DateTime.parse(bookmark["date"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: textColor.withAlpha(150),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${bookmark["chapter"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textColor.withAlpha(150),
                                  ),
                                ),
                                if (bookmark["note"] != null) ...[
                                  SizedBox(height: spXs),
                                  Text(
                                    "${bookmark["note"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Notes Panel
          if (showNotes)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 300,
                color: backgroundColor,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: textColor.withAlpha(50)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Notes & Highlights",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.close),
                            color: textColor,
                            onPressed: () {
                              showNotes = false;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(spSm),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          Color highlightColor = note["color"] == "yellow" 
                              ? warningColor.withAlpha(50)
                              : infoColor.withAlpha(50);
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: highlightColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: highlightColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Page ${note["page"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${DateTime.parse(note["date"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: textColor.withAlpha(150),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: note["color"] == "yellow" 
                                        ? warningColor.withAlpha(100)
                                        : infoColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${note["highlight"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: textColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${note["text"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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

  void _showReaderSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reader Settings",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Font Size
                  Text(
                    "Font Size",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: textColor,
                        onPressed: () {
                          _adjustFontSize(-1);
                          setModalState(() {});
                        },
                      ),
                      Expanded(
                        child: Slider(
                          value: fontSize,
                          min: 12,
                          max: 24,
                          divisions: 12,
                          activeColor: primaryColor,
                          inactiveColor: textColor.withAlpha(50),
                          onChanged: (value) {
                            fontSize = value;
                            setState(() {});
                            setModalState(() {});
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: textColor,
                        onPressed: () {
                          _adjustFontSize(1);
                          setModalState(() {});
                        },
                      ),
                    ],
                  ),
                  Text(
                    "Sample text with current font size",
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Line Height
                  Text(
                    "Line Height",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Slider(
                    value: lineHeight,
                    min: 1.0,
                    max: 2.0,
                    divisions: 10,
                    activeColor: primaryColor,
                    inactiveColor: textColor.withAlpha(50),
                    onChanged: (value) {
                      lineHeight = value;
                      setState(() {});
                      setModalState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Theme Toggle
                  Row(
                    children: [
                      Text(
                        "Night Mode",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: isNightMode,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          _toggleNightMode();
                          setModalState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reset to Default",
                          size: bs.sm,
                          onPressed: () {
                            fontSize = 16.0;
                            lineHeight = 1.5;
                            isNightMode = false;
                            backgroundColor = Colors.white;
                            textColor = Colors.black;
                            setState(() {});
                            setModalState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Close",
                          size: bs.sm,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
