import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaResearchNotesView extends StatefulWidget {
  const LcaResearchNotesView({super.key});

  @override
  State<LcaResearchNotesView> createState() => _LcaResearchNotesViewState();
}

class _LcaResearchNotesViewState extends State<LcaResearchNotesView> {
  String searchQuery = "";
  String selectedCategory = "All Categories";
  String selectedTag = "All Tags";
  String sortBy = "Recent";
  bool isGridView = true;
  String noteTitle = "";
  String noteContent = "";
  String selectedNoteCategory = "General";
  List<String> noteTags = [];
  String newTag = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "General", "value": "General"},
    {"label": "Case Research", "value": "Case Research"},
    {"label": "Statute Analysis", "value": "Statute Analysis"},
    {"label": "Legal Precedents", "value": "Legal Precedents"},
    {"label": "Client Notes", "value": "Client Notes"},
    {"label": "Meeting Notes", "value": "Meeting Notes"},
    {"label": "Research Ideas", "value": "Research Ideas"},
  ];

  List<Map<String, dynamic>> tags = [
    {"label": "All Tags", "value": "All Tags"},
    {"label": "urgent", "value": "urgent"},
    {"label": "follow-up", "value": "follow-up"},
    {"label": "important", "value": "important"},
    {"label": "draft", "value": "draft"},
    {"label": "completed", "value": "completed"},
    {"label": "research", "value": "research"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Oldest", "value": "Oldest"},
    {"label": "Title A-Z", "value": "Title A-Z"},
    {"label": "Title Z-A", "value": "Title Z-A"},
    {"label": "Category", "value": "Category"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "General", "value": "General"},
    {"label": "Case Research", "value": "Case Research"},
    {"label": "Statute Analysis", "value": "Statute Analysis"},
    {"label": "Legal Precedents", "value": "Legal Precedents"},
    {"label": "Client Notes", "value": "Client Notes"},
    {"label": "Meeting Notes", "value": "Meeting Notes"},
    {"label": "Research Ideas", "value": "Research Ideas"},
  ];

  List<Map<String, dynamic>> researchNotes = [
    {
      "id": "1",
      "title": "Constitutional Law Analysis - First Amendment",
      "content": "Key findings on freedom of speech precedents and their application to digital platforms. Analyzing Brandenburg v. Ohio and its modern interpretations...",
      "category": "Case Research",
      "tags": ["constitutional", "first-amendment", "important"],
      "created_at": "2024-12-15T10:30:00Z",
      "updated_at": "2024-12-15T14:45:00Z",
      "word_count": 1247,
      "is_pinned": true,
      "color": "blue",
    },
    {
      "id": "2",
      "title": "Contract Law - Force Majeure Clauses",
      "content": "Research on force majeure applications during pandemic conditions. Analysis of recent court decisions and their impact on contract enforcement...",
      "category": "Legal Precedents",
      "tags": ["contracts", "covid-19", "force-majeure"],
      "created_at": "2024-12-14T16:20:00Z",
      "updated_at": "2024-12-14T18:35:00Z",
      "word_count": 892,
      "is_pinned": false,
      "color": "green",
    },
    {
      "id": "3",
      "title": "Client Meeting - Smith v. Jones Case",
      "content": "Discussion points from client meeting regarding property dispute. Key evidence collected and next steps outlined for the litigation process...",
      "category": "Client Notes",
      "tags": ["client-meeting", "property-law", "urgent"],
      "created_at": "2024-12-13T09:15:00Z",
      "updated_at": "2024-12-13T11:30:00Z",
      "word_count": 634,
      "is_pinned": true,
      "color": "orange",
    },
    {
      "id": "4",
      "title": "Patent Law Research - Software Patents",
      "content": "Comprehensive analysis of software patent eligibility following Alice Corp decision. Impact on tech industry and litigation strategies...",
      "category": "Statute Analysis",
      "tags": ["patent-law", "software", "alice-corp"],
      "created_at": "2024-12-12T13:45:00Z",
      "updated_at": "2024-12-12T17:20:00Z",
      "word_count": 1156,
      "is_pinned": false,
      "color": "purple",
    },
    {
      "id": "5",
      "title": "Employment law Update - Remote Work Policies",
      "content": "Recent developments in employment law regarding remote work arrangements and employer obligations post-pandemic...",
      "category": "Research Ideas",
      "tags": ["employment-law", "remote-work", "draft"],
      "created_at": "2024-12-11T08:30:00Z",
      "updated_at": "2024-12-11T12:15:00Z",
      "word_count": 743,
      "is_pinned": false,
      "color": "teal",
    },
    {
      "id": "6",
      "title": "Team Meeting - Case Strategy Discussion",
      "content": "Strategic planning session for upcoming trial. Witness preparation, evidence presentation order, and jury selection considerations...",
      "category": "Meeting Notes",
      "tags": ["team-meeting", "trial-prep", "follow-up"],
      "created_at": "2024-12-10T14:00:00Z",
      "updated_at": "2024-12-10T16:30:00Z",
      "word_count": 521,
      "is_pinned": false,
      "color": "red",
    },
  ];

  List<Map<String, dynamic>> get filteredNotes {
    return researchNotes.where((note) {
      bool matchesSearch = searchQuery.isEmpty ||
          (note["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (note["content"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All Categories" || 
          note["category"] == selectedCategory;
      
      bool matchesTag = selectedTag == "All Tags" ||
          (note["tags"] as List).contains(selectedTag);
      
      return matchesSearch && matchesCategory && matchesTag;
    }).toList();
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Case Research": return primaryColor;
      case "Statute Analysis": return successColor;
      case "Legal Precedents": return infoColor;
      case "Client Notes": return warningColor;
      case "Meeting Notes": return dangerColor;
      case "Research Ideas": return Colors.purple;
      default: return disabledBoldColor;
    }
  }

  void _showCreateNoteDialog() {
    noteTitle = "";
    noteContent = "";
    selectedNoteCategory = "General";
    noteTags = [];
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            "Create New Note",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QTextField(
                    label: "Title",
                    value: noteTitle,
                    hint: "Enter note title",
                    validator: Validator.required,
                    onChanged: (value) {
                      noteTitle = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedNoteCategory,
                    onChanged: (value, label) {
                      selectedNoteCategory = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Content",
                    value: noteContent,
                    hint: "Enter your research notes here...",
                    validator: Validator.required,
                    onChanged: (value) {
                      noteContent = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Add Tag",
                          value: newTag,
                          hint: "Enter tag and press Add",
                          onChanged: (value) {
                            newTag = value;
                            setDialogState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Add",
                        size: bs.sm,
                        onPressed: () {
                          if (newTag.isNotEmpty && !noteTags.contains(newTag)) {
                            noteTags.add(newTag);
                            newTag = "";
                            setDialogState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  if (noteTags.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: noteTags.map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(50)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () {
                                noteTags.remove(tag);
                                setDialogState(() {});
                              },
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
            QButton(
              label: "Create Note",
              size: bs.sm,
              onPressed: () {
                if (noteTitle.isNotEmpty && noteContent.isNotEmpty) {
                  Navigator.pop(context);
                  ss("Note created successfully");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Notes"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showCreateNoteDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QTextField(
                    label: "Search Notes",
                    value: searchQuery,
                    hint: "Search by title or content...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
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
                          label: "Tag",
                          items: tags,
                          value: selectedTag,
                          onChanged: (value, label) {
                            selectedTag = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.note,
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${filteredNotes.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Notes",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.push_pin,
                          color: successColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${researchNotes.where((note) => note["is_pinned"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Pinned",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.text_fields,
                          color: infoColor,
                          size: 28,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${(researchNotes.fold(0, (sum, note) => sum + (note["word_count"] as int)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Words",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Notes List/Grid
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredNotes.map((note) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: getCategoryColor("${note["category"]}"),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            if (note["is_pinned"] == true)
                              Icon(
                                Icons.push_pin,
                                color: warningColor,
                                size: 16,
                              ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: getCategoryColor("${note["category"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${note["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: getCategoryColor("${note["category"]}"),
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${note["content"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        if ((note["tags"] as List).isNotEmpty)
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (note["tags"] as List).take(3).map((tag) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: disabledBoldColor,
                                ),
                              ),
                            )).toList(),
                          ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${(note["word_count"] as int)} words",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              DateTime.parse("${note["updated_at"]}").dMMMy,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Column(
                children: filteredNotes.map((note) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: getCategoryColor("${note["category"]}"),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: getCategoryColor("${note["category"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.note,
                            color: getCategoryColor("${note["category"]}"),
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (note["is_pinned"] == true)
                                    Icon(
                                      Icons.push_pin,
                                      color: warningColor,
                                      size: 16,
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: getCategoryColor("${note["category"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${note["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getCategoryColor("${note["category"]}"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${(note["word_count"] as int)} words",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    DateTime.parse("${note["updated_at"]}").dMMMy,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${note["content"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateNoteDialog,
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
