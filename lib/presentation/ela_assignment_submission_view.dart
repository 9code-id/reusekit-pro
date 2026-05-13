import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAssignmentSubmissionView extends StatefulWidget {
  const ElaAssignmentSubmissionView({super.key});

  @override
  State<ElaAssignmentSubmissionView> createState() => _ElaAssignmentSubmissionViewState();
}

class _ElaAssignmentSubmissionViewState extends State<ElaAssignmentSubmissionView> {
  final formKey = GlobalKey<FormState>();
  
  String submissionTitle = "";
  String submissionContent = "";
  List<String> attachments = [];
  String submissionNotes = "";
  bool isDraft = false;
  bool isSubmitting = false;
  
  Map<String, dynamic> assignment = {
    "id": 1,
    "title": "Poetry Analysis: Robert Frost",
    "description": "Analyze themes and literary devices in 'The Road Not Taken'",
    "due_date": "2024-12-20",
    "points": 100,
    "submission_type": "Document",
    "instructions": "Write a 500-word analysis focusing on metaphors and symbolism.",
    "requirements": [
      "Minimum 500 words",
      "MLA format required",
      "At least 3 literary devices analyzed",
      "Include direct quotes from the poem",
      "Proper citations and bibliography"
    ]
  };

  List<Map<String, dynamic>> savedDrafts = [
    {
      "id": 1,
      "title": "Draft 1 - Introduction Complete",
      "content": "In Robert Frost's poem 'The Road Not Taken', the speaker reflects on a moment of choice that has shaped their entire life...",
      "word_count": 156,
      "saved_date": "2024-12-14 10:30",
      "is_auto_save": false
    },
    {
      "id": 2,
      "title": "Auto-save Draft",
      "content": "The metaphor of the diverging roads represents life's choices and their consequences...",
      "word_count": 89,
      "saved_date": "2024-12-14 11:45",
      "is_auto_save": true
    }
  ];

  void _saveDraft() {
    if (submissionContent.trim().isEmpty) {
      se("Please add some content before saving draft");
      return;
    }
    
    isDraft = true;
    setState(() {});
    
    // Simulate saving
    Future.delayed(Duration(seconds: 1), () {
      ss("Draft saved successfully!");
      isDraft = false;
      setState(() {});
    });
  }

  void _submitAssignment() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    if (submissionContent.trim().isEmpty) {
      se("Please add your submission content");
      return;
    }
    
    bool isConfirmed = await confirm("Are you sure you want to submit this assignment? You won't be able to edit it afterwards.");
    if (!isConfirmed) return;
    
    isSubmitting = true;
    setState(() {});
    
    // Simulate submission
    Future.delayed(Duration(seconds: 2), () {
      isSubmitting = false;
      setState(() {});
      ss("Assignment submitted successfully!");
      back();
    });
  }

  void _loadDraft(Map<String, dynamic> draft) {
    submissionContent = draft["content"];
    submissionTitle = draft["title"];
    setState(() {});
    ss("Draft loaded successfully!");
  }

  void _previewSubmission() {
    // navigateTo(AssignmentPreviewView(content: submissionContent))
  }

  int get wordCount {
    return submissionContent.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Assignment"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () => _previewSubmission(),
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveDraft(),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assignment info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: primaryColor.withAlpha(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${assignment["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${assignment["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${DateTime.parse(assignment["due_date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${assignment["points"]} points",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Requirements checklist
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Requirements Checklist",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    ...(assignment["requirements"] as List<String>).map((requirement) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box_outline_blank,
                              color: disabledBoldColor,
                              size: 18,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                requirement,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Saved drafts
              if (savedDrafts.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saved Drafts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      
                      ...savedDrafts.map((draft) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: infoColor.withAlpha(50),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                draft["is_auto_save"] ? Icons.autorenew : Icons.save,
                                color: infoColor,
                                size: 18,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${draft["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${draft["word_count"]} words • ${draft["saved_date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _loadDraft(draft),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Load",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
              ],
              
              // Submission form
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Submission",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    QTextField(
                      label: "Submission Title",
                      value: submissionTitle,
                      validator: Validator.required,
                      onChanged: (value) {
                        submissionTitle = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spMd),
                    
                    QMemoField(
                      label: "Content",
                      value: submissionContent,
                      hint: "Write your analysis here...",
                      maxLines: 15,
                      validator: Validator.required,
                      onChanged: (value) {
                        submissionContent = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Word count indicator
                    Row(
                      children: [
                        Text(
                          "Word count: $wordCount",
                          style: TextStyle(
                            fontSize: 12,
                            color: wordCount >= 500 ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (wordCount < 500) ...[
                          SizedBox(width: spSm),
                          Text(
                            "(Minimum: 500 words)",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    QAttachmentPicker(
                      label: "Attachments",
                      value: attachments,
                      hint: "Add supporting documents or images",
                      maxAttachments: 5,
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spMd),
                    
                    QMemoField(
                      label: "Additional Notes (Optional)",
                      value: submissionNotes,
                      hint: "Any additional comments for your teacher...",
                      maxLines: 3,
                      onChanged: (value) {
                        submissionNotes = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Action buttons
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isDraft ? "Saving..." : "Save Draft",
                          size: bs.md,
                          onPressed: isDraft ? null : () => _saveDraft(),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Preview",
                          size: bs.md,
                          onPressed: () => _previewSubmission(),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isSubmitting ? "Submitting..." : "Submit Assignment",
                      size: bs.md,
                      onPressed: isSubmitting ? null : () => _submitAssignment(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
