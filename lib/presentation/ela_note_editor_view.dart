import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaNoteEditorView extends StatefulWidget {
  const ElaNoteEditorView({super.key});

  @override
  State<ElaNoteEditorView> createState() => _ElaNoteEditorViewState();
}

class _ElaNoteEditorViewState extends State<ElaNoteEditorView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isEditing = true; // true for editing existing note, false for new note
  
  String noteTitle = "Character Analysis Techniques";
  String noteContent = "Important techniques for analyzing characters:\n\n1. Look for direct characterization - what the author tells us directly\n2. Indirect characterization - what we learn through actions, dialogue, and thoughts\n3. Character development - how they change throughout the story\n4. Motivations - why characters make certain decisions\n\nExample: In Harry Potter, Harry's bravery is shown through his actions (indirect) and also stated directly by other characters.";
  String selectedCategory = "Lesson Notes";
  String selectedSubject = "Literature";
  String selectedColor = "yellow";
  String sourceTitle = "Introduction to Character Analysis Lesson";
  List<String> tags = ["character analysis", "literature", "writing techniques"];
  String newTag = "";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Lesson Notes", "value": "Lesson Notes"},
    {"label": "Reading Notes", "value": "Reading Notes"},
    {"label": "Personal Notes", "value": "Personal Notes"},
    {"label": "Study Notes", "value": "Study Notes"},
    {"label": "Quick Notes", "value": "Quick Notes"},
  ];

  List<Map<String, dynamic>> subjectOptions = [
    {"label": "Literature", "value": "Literature"},
    {"label": "Reading", "value": "Reading"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Grammar", "value": "Grammar"},
    {"label": "Vocabulary", "value": "Vocabulary"},
  ];

  List<Map<String, dynamic>> colorOptions = [
    {"label": "Yellow", "value": "yellow", "color": Colors.yellow},
    {"label": "Blue", "value": "blue", "color": Colors.blue},
    {"label": "Green", "value": "green", "color": Colors.green},
    {"label": "Purple", "value": "purple", "color": Colors.purple},
    {"label": "Orange", "value": "orange", "color": Colors.orange},
    {"label": "Red", "value": "red", "color": Colors.red},
    {"label": "Pink", "value": "pink", "color": Colors.pink},
  ];

  Map<String, dynamic> note = {
    "id": "note_001",
    "createdAt": "2024-03-15T10:30:00Z",
    "updatedAt": "2024-03-15T14:20:00Z",
    "wordCount": 87,
  };

  void _addTag() {
    if (newTag.trim().isNotEmpty && !tags.contains(newTag.trim().toLowerCase())) {
      tags.add(newTag.trim().toLowerCase());
      newTag = "";
      setState(() {});
    }
  }

  void _removeTag(String tag) {
    tags.remove(tag);
    setState(() {});
  }

  void _saveNote() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (noteTitle.trim().isEmpty) {
      se("Please enter a note title");
      return;
    }

    if (noteContent.trim().isEmpty) {
      se("Please enter note content");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate save operation
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss(isEditing ? "Note updated successfully" : "Note saved successfully");
    
    // Navigate back
    back();
  }

  void _deleteNote() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this note?");
    if (isConfirmed) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 1));

      ss("Note deleted successfully");
      back();
    }
  }

  void _previewNote() {
    // Show note preview
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Note Preview",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border(
                    left: BorderSide(
                      color: _getNoteColor(selectedColor),
                      width: 4,
                    ),
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      noteTitle,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
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
                            selectedSubject,
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
                            selectedCategory,
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
                    
                    Text(
                      noteContent,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    
                    if (tags.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(height: spSm),
                          Wrap(
                            spacing: spXs,
                            runSpacing: 4,
                            children: tags.map((tag) {
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
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return "${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  int get wordCount {
    return noteContent.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Note" : "New Note"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: _previewNote,
          ),
          if (isEditing)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteNote,
            ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Note Info (if editing)
              if (isEditing)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Created: ${_formatDate("${note["createdAt"]}")}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Updated: ${_formatDate("${note["updatedAt"]}")}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "$wordCount words",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              // Title
              QTextField(
                label: "Note Title",
                value: noteTitle,
                hint: "Enter a descriptive title for your note",
                validator: Validator.required,
                onChanged: (value) {
                  noteTitle = value;
                  setState(() {});
                },
              ),

              // Content
              QMemoField(
                label: "Note Content",
                value: noteContent,
                hint: "Write your note content here...\n\nTip: Use bullet points, numbers, or formatting to organize your thoughts clearly.",
                validator: Validator.required,
                onChanged: (value) {
                  noteContent = value;
                  setState(() {});
                },
              ),

              // Metadata Row
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
                ],
              ),

              // Source (if applicable)
              if (isEditing)
                QTextField(
                  label: "Source",
                  value: sourceTitle,
                  hint: "Where did this note come from?",
                  onChanged: (value) {
                    sourceTitle = value;
                    setState(() {});
                  },
                ),

              // Color Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note Color",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: colorOptions.map((colorOption) {
                      bool isSelected = selectedColor == colorOption["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedColor = colorOption["value"];
                          setState(() {});
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colorOption["color"],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withValues(alpha: 0.3),
                              width: isSelected ? 3 : 1,
                            ),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              // Tags
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tags",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  
                  // Add Tag
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Add Tag",
                          value: newTag,
                          hint: "Enter a tag and press Add",
                          onChanged: (value) {
                            newTag = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Add",
                        size: bs.sm,
                        onPressed: _addTag,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Current Tags
                  if (tags.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Tags:",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: tags.map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "#$tag",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () => _removeTag(tag),
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "No tags added yet. Tags help you organize and find your notes later.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),

              // Word Count Display
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.text_fields,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Word Count: $wordCount",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Characters: ${noteContent.length}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Preview",
                      icon: Icons.preview,
                      size: bs.md,
                      onPressed: _previewNote,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: loading 
                          ? "Saving..." 
                          : (isEditing ? "Update Note" : "Save Note"),
                      icon: loading ? null : Icons.save,
                      size: bs.md,
                      onPressed: loading ? null : _saveNote,
                    ),
                  ),
                ],
              ),

              if (loading)
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Saving your note...",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
