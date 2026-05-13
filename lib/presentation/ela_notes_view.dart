import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaNotesView extends StatefulWidget {
  const ElaNotesView({super.key});

  @override
  State<ElaNotesView> createState() => _ElaNotesViewState();
}

class _ElaNotesViewState extends State<ElaNotesView> {
  bool loading = true;
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedSubject = "All Subjects";
  String sortBy = "Recent";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Lesson Notes", "value": "Lesson Notes"},
    {"label": "Reading Notes", "value": "Reading Notes"},
    {"label": "Personal Notes", "value": "Personal Notes"},
    {"label": "Study Notes", "value": "Study Notes"},
    {"label": "Quick Notes", "value": "Quick Notes"},
  ];

  List<Map<String, dynamic>> subjectOptions = [
    {"label": "All Subjects", "value": "All Subjects"},
    {"label": "Literature", "value": "Literature"},
    {"label": "Reading", "value": "Reading"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Grammar", "value": "Grammar"},
    {"label": "Vocabulary", "value": "Vocabulary"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Oldest", "value": "Oldest"},
    {"label": "Title A-Z", "value": "Title A-Z"},
    {"label": "Title Z-A", "value": "Title Z-A"},
    {"label": "Subject", "value": "Subject"},
  ];

  List<Map<String, dynamic>> notes = [
    {
      "id": "note_001",
      "title": "Character Analysis Techniques",
      "content": "Important techniques for analyzing characters:\n\n1. Look for direct characterization - what the author tells us directly\n2. Indirect characterization - what we learn through actions, dialogue, and thoughts\n3. Character development - how they change throughout the story\n4. Motivations - why characters make certain decisions\n\nExample: In Harry Potter, Harry's bravery is shown through his actions (indirect) and also stated directly by other characters.",
      "category": "Lesson Notes",
      "subject": "Literature",
      "source": "Introduction to Character Analysis Lesson",
      "sourceType": "lesson",
      "sourceId": "lesson_001",
      "tags": ["character analysis", "literature", "writing techniques"],
      "createdAt": "2024-03-15T10:30:00Z",
      "updatedAt": "2024-03-15T14:20:00Z",
      "isFavorite": true,
      "color": "yellow",
      "wordCount": 87,
    },
    {
      "id": "note_002",
      "title": "Water Cycle Key Points",
      "content": "The water cycle is nature's recycling system!\n\nKey processes:\n• Evaporation - liquid water becomes water vapor (sun provides energy)\n• Condensation - water vapor cools and forms clouds\n• Precipitation - water falls as rain, snow, sleet, or hail\n• Collection - water gathers in oceans, lakes, rivers\n\nReal-world connection: I saw this when mom was cooking pasta - the steam is evaporation happening in our kitchen!",
      "category": "Reading Notes",
      "subject": "Reading",
      "source": "The Water Cycle - Dr. Sarah Chen",
      "sourceType": "reading",
      "sourceId": "material_002",
      "tags": ["water cycle", "science", "environment"],
      "createdAt": "2024-03-15T11:45:00Z",
      "updatedAt": "2024-03-15T11:45:00Z",
      "isFavorite": false,
      "color": "blue",
      "wordCount": 73,
    },
    {
      "id": "note_003",
      "title": "Vocabulary Building Strategies",
      "content": "Effective ways to build vocabulary:\n\n1. Context Clues - use surrounding words to guess meaning\n2. Word Parts - learn prefixes, roots, and suffixes\n3. Word Associations - connect new words to familiar ones\n4. Practice in Context - use new words in sentences\n5. Daily Reading - exposure to diverse vocabulary\n\nRemember: Don't just memorize definitions, understand how words are used!",
      "category": "Study Notes",
      "subject": "Vocabulary",
      "source": "Personal Study Session",
      "sourceType": "personal",
      "sourceId": null,
      "tags": ["vocabulary", "learning strategies", "reading"],
      "createdAt": "2024-03-14T16:20:00Z",
      "updatedAt": "2024-03-14T16:20:00Z",
      "isFavorite": true,
      "color": "green",
      "wordCount": 65,
    },
    {
      "id": "note_004",
      "title": "Poetry Elements to Remember",
      "content": "Key elements of poetry:\n\n• Rhythm - the beat of the poem\n• Rhyme - words that sound alike\n• Meter - pattern of stressed/unstressed syllables\n• Imagery - descriptive language that creates pictures\n• Metaphor - comparing unlike things directly\n• Simile - comparing using 'like' or 'as'\n• Alliteration - repetition of beginning sounds\n\nTip: Read poems aloud to hear the rhythm and rhyme!",
      "category": "Lesson Notes",
      "subject": "Literature",
      "source": "Poetry Elements and Structure Lesson",
      "sourceType": "lesson",
      "sourceId": "lesson_002",
      "tags": ["poetry", "literary elements", "rhythm", "rhyme"],
      "createdAt": "2024-03-14T09:15:00Z",
      "updatedAt": "2024-03-14T09:15:00Z",
      "isFavorite": false,
      "color": "purple",
      "wordCount": 68,
    },
    {
      "id": "note_005",
      "title": "Quick Writing Ideas",
      "content": "Story starters for creative writing:\n\n• A mysterious door appears in your bedroom wall\n• You wake up and everyone else has disappeared\n• Your pet can suddenly talk for one day\n• You find a time machine in your garage\n• A letter arrives addressed to you from 100 years ago\n\nCharacter ideas:\n• A shy kid who becomes brave\n• A robot learning about friendship\n• An old tree that has seen everything",
      "category": "Quick Notes",
      "subject": "Writing",
      "source": "Creative Writing Brainstorm",
      "sourceType": "personal",
      "sourceId": null,
      "tags": ["creative writing", "story ideas", "inspiration"],
      "createdAt": "2024-03-13T15:30:00Z",
      "updatedAt": "2024-03-13T15:30:00Z",
      "isFavorite": false,
      "color": "orange",
      "wordCount": 52,
    },
    {
      "id": "note_006",
      "title": "Grammar Rules - Punctuation",
      "content": "Important punctuation rules:\n\nCommas:\n• Use before 'and' in a list of 3+ items\n• After introductory words/phrases\n• Around extra information\n\nPeriods:\n• End of statements\n• After abbreviations\n\nQuestion marks:\n• End of questions only\n\nExclamation points:\n• Show strong emotion\n• Don't overuse them!\n\nQuotation marks:\n• Around exact words someone said\n• Punctuation usually goes inside",
      "category": "Study Notes",
      "subject": "Grammar",
      "source": "Grammar Review Session",
      "sourceType": "personal",
      "sourceId": null,
      "tags": ["grammar", "punctuation", "writing mechanics"],
      "createdAt": "2024-03-12T14:00:00Z",
      "updatedAt": "2024-03-12T14:00:00Z",
      "isFavorite": true,
      "color": "red",
      "wordCount": 78,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredAndSortedNotes {
    List<Map<String, dynamic>> filtered = notes.where((note) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${note["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${note["content"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (note["tags"] as List).any((tag) => 
              "$tag".toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All Categories" || 
          note["category"] == selectedCategory;
      
      bool matchesSubject = selectedSubject == "All Subjects" || 
          note["subject"] == selectedSubject;
      
      return matchesSearch && matchesCategory && matchesSubject;
    }).toList();

    // Sort the filtered results
    switch (sortBy) {
      case "Recent":
        filtered.sort((a, b) => 
            DateTime.parse("${b["updatedAt"]}").compareTo(DateTime.parse("${a["updatedAt"]}")));
        break;
      case "Oldest":
        filtered.sort((a, b) => 
            DateTime.parse("${a["updatedAt"]}").compareTo(DateTime.parse("${b["updatedAt"]}")));
        break;
      case "Title A-Z":
        filtered.sort((a, b) => "${a["title"]}".compareTo("${b["title"]}"));
        break;
      case "Title Z-A":
        filtered.sort((a, b) => "${b["title"]}".compareTo("${a["title"]}"));
        break;
      case "Subject":
        filtered.sort((a, b) => "${a["subject"]}".compareTo("${b["subject"]}"));
        break;
    }

    return filtered;
  }

  void _toggleFavorite(String noteId) {
    int index = notes.indexWhere((n) => n["id"] == noteId);
    if (index != -1) {
      notes[index]["isFavorite"] = !notes[index]["isFavorite"];
      setState(() {});
      
      String message = notes[index]["isFavorite"] 
          ? "Added to favorites" 
          : "Removed from favorites";
      ss(message);
    }
  }

  void _deleteNote(String noteId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this note?");
    if (isConfirmed) {
      notes.removeWhere((n) => n["id"] == noteId);
      setState(() {});
      ss("Note deleted successfully");
    }
  }

  Color _getNoteColor(String color) {
    switch (color) {
      case "yellow":
        return Colors.yellow;
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "purple":
        return Colors.purple;
      case "orange":
        return Colors.orange;
      case "red":
        return Colors.red;
      case "pink":
        return Colors.pink;
      default:
        return Colors.yellow;
    }
  }

  IconData _getSourceIcon(String sourceType) {
    switch (sourceType) {
      case "lesson":
        return Icons.school;
      case "reading":
        return Icons.menu_book;
      case "personal":
        return Icons.edit;
      default:
        return Icons.note;
    }
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("My Notes"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayNotes = filteredAndSortedNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to note editor
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Open search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search notes...",
              value: searchQuery,
              hint: "Search by title, content, or tags",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters and Sort
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Subject",
                    items: subjectOptions,
                    value: selectedSubject,
                    onChanged: (value, label) {
                      selectedSubject = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    "${displayNotes.length} notes found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  if (displayNotes.where((n) => n["isFavorite"] == true).isNotEmpty)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${displayNotes.where((n) => n["isFavorite"] == true).length} favorites",
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

            // Notes List
            if (displayNotes.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.note,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No notes found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new note",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Create Note",
                      icon: Icons.add,
                      size: bs.md,
                      onPressed: () {
                        // Navigate to note editor
                      },
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayNotes.map((note) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: _getNoteColor("${note["color"]}"),
                          width: 4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${note["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () => _toggleFavorite("${note["id"]}"),
                                child: Icon(
                                  note["isFavorite"] ? Icons.star : Icons.star_border,
                                  color: note["isFavorite"] ? warningColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show note options
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),

                          // Metadata
                          Row(
                            children: [
                              Icon(
                                _getSourceIcon("${note["sourceType"]}"),
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${note["source"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${note["subject"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${note["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          // Content Preview
                          Text(
                            "${note["content"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),

                          // Tags
                          if ((note["tags"] as List).isNotEmpty)
                            Column(
                              children: [
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: 4,
                                  children: (note["tags"] as List).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "#$tag",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: spSm),
                              ],
                            ),

                          // Footer
                          Row(
                            children: [
                              Text(
                                _formatDate("${note["updatedAt"]}"),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${note["wordCount"]} words",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to note editor
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.delete,
                                size: bs.sm,
                                onPressed: () => _deleteNote("${note["id"]}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to note editor
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
