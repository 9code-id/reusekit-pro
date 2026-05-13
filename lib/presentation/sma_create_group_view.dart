import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaCreateGroupView extends StatefulWidget {
  const SmaCreateGroupView({super.key});

  @override
  State<SmaCreateGroupView> createState() => _SmaCreateGroupViewState();
}

class _SmaCreateGroupViewState extends State<SmaCreateGroupView> {
  final formKey = GlobalKey<FormState>();
  
  String groupName = "";
  String description = "";
  String category = "";
  String privacy = "public";
  String coverImage = "";
  List<String> tags = [];
  String newTag = "";
  List<String> rules = [];
  String newRule = "";
  bool allowInvites = true;
  bool requireApproval = false;
  bool enableDiscussion = true;
  bool enablePolls = true;
  bool enableEvents = true;
  bool isLoading = false;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Arts & Design", "value": "arts"},
    {"label": "Sports & Fitness", "value": "sports"},
    {"label": "Lifestyle", "value": "lifestyle"},
    {"label": "Education", "value": "education"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Travel", "value": "travel"},
    {"label": "Food & Cooking", "value": "food"},
    {"label": "Health & Wellness", "value": "health"},
  ];
  
  List<Map<String, dynamic>> privacyOptions = [
    {"label": "Public", "value": "public"},
    {"label": "Private", "value": "private"},
    {"label": "Secret", "value": "secret"},
  ];

  void _addTag() {
    if (newTag.isNotEmpty && !tags.contains(newTag)) {
      setState(() {
        tags.add(newTag);
        newTag = "";
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  void _addRule() {
    if (newRule.isNotEmpty && !rules.contains(newRule)) {
      setState(() {
        rules.add(newRule);
        newRule = "";
      });
    }
  }

  void _removeRule(String rule) {
    setState(() {
      rules.remove(rule);
    });
  }

  void _createGroup() async {
    if (!formKey.currentState!.validate()) return;
    if (category.isEmpty) {
      se("Please select a category");
      return;
    }
    if (tags.isEmpty) {
      se("Please add at least one tag");
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    ss("Group created successfully!");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
        actions: [
          if (isLoading)
            Container(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _createGroup,
              child: Text(
                "Create",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Basic Information Section
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
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Cover Image
                    QImagePicker(
                      label: "Cover Image",
                      value: coverImage,
                      hint: "Upload a cover image for your group",
                      validator: Validator.required,
                      onChanged: (value) {
                        coverImage = value;
                        setState(() {});
                      },
                    ),
                    
                    // Group Name
                    QTextField(
                      label: "Group Name",
                      value: groupName,
                      hint: "Enter a unique and descriptive name",
                      validator: Validator.required,
                      onChanged: (value) {
                        groupName = value;
                        setState(() {});
                      },
                    ),
                    
                    // Description
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe what your group is about",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Category and Privacy Section
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
                      "Category & Privacy",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Category
                    QDropdownField(
                      label: "Category",
                      items: categoryOptions,
                      value: category,
                      onChanged: (value, label) {
                        category = value;
                        setState(() {});
                      },
                    ),
                    
                    // Privacy
                    QDropdownField(
                      label: "Privacy Setting",
                      items: privacyOptions,
                      value: privacy,
                      onChanged: (value, label) {
                        privacy = value;
                        setState(() {});
                      },
                    ),
                    
                    // Privacy Description
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            _getPrivacyTitle(privacy),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            _getPrivacyDescription(privacy),
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tags Section
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
                      "Tags",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Add Tag
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add Tag",
                            value: newTag,
                            hint: "Enter a relevant tag",
                            onChanged: (value) {
                              newTag = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _addTag,
                        ),
                      ],
                    ),
                    
                    // Tags List
                    if (tags.isNotEmpty)
                      Wrap(
                        spacing: spSm,
                        runSpacing: spSm,
                        children: tags.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                GestureDetector(
                                  onTap: () => _removeTag(tag),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
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
              ),
              
              // Rules Section
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
                      "Group Rules",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Add Rule
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add Rule",
                            value: newRule,
                            hint: "Enter a group rule",
                            onChanged: (value) {
                              newRule = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _addRule,
                        ),
                      ],
                    ),
                    
                    // Rules List
                    if (rules.isNotEmpty)
                      Column(
                        spacing: spSm,
                        children: rules.asMap().entries.map((entry) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${entry.key + 1}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${entry.value}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _removeRule(entry.value),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: dangerColor,
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
              
              // Group Settings Section
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
                      "Group Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Member Settings
                    QSwitch(
                      items: [
                        {
                          "label": "Allow members to invite others",
                          "value": "invites",
                          "checked": allowInvites,
                        }
                      ],
                      value: [
                        if (allowInvites) {
                          "label": "Allow members to invite others",
                          "value": "invites",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        allowInvites = values.any((v) => v["value"] == "invites");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Require admin approval for new members",
                          "value": "approval",
                          "checked": requireApproval,
                        }
                      ],
                      value: [
                        if (requireApproval) {
                          "label": "Require admin approval for new members",
                          "value": "approval",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        requireApproval = values.any((v) => v["value"] == "approval");
                        setState(() {});
                      },
                    ),
                    
                    // Feature Settings
                    Text(
                      "Enable Features",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Discussion Posts",
                          "value": "discussion",
                          "checked": enableDiscussion,
                        }
                      ],
                      value: [
                        if (enableDiscussion) {
                          "label": "Discussion Posts",
                          "value": "discussion",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        enableDiscussion = values.any((v) => v["value"] == "discussion");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Polls & Surveys",
                          "value": "polls",
                          "checked": enablePolls,
                        }
                      ],
                      value: [
                        if (enablePolls) {
                          "label": "Polls & Surveys",
                          "value": "polls",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        enablePolls = values.any((v) => v["value"] == "polls");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Events & Meetups",
                          "value": "events",
                          "checked": enableEvents,
                        }
                      ],
                      value: [
                        if (enableEvents) {
                          "label": "Events & Meetups",
                          "value": "events",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        enableEvents = values.any((v) => v["value"] == "events");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Create Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: isLoading ? "Creating Group..." : "Create Group",
                  icon: isLoading ? null : Icons.group_add,
                  size: bs.md,
                  onPressed: isLoading ? null : _createGroup,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPrivacyTitle(String privacy) {
    switch (privacy) {
      case "public":
        return "Public Group";
      case "private":
        return "Private Group";
      case "secret":
        return "Secret Group";
      default:
        return "Unknown";
    }
  }

  String _getPrivacyDescription(String privacy) {
    switch (privacy) {
      case "public":
        return "Anyone can see the group, its members, and their posts. Anyone can join.";
      case "private":
        return "Anyone can see the group and its members, but only members can see posts. People must request to join.";
      case "secret":
        return "Only members can see the group, its members, and their posts. People must be invited to join.";
      default:
        return "";
    }
  }
}
