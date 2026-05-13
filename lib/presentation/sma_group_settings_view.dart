import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaGroupSettingsView extends StatefulWidget {
  const SmaGroupSettingsView({super.key});

  @override
  State<SmaGroupSettingsView> createState() => _SmaGroupSettingsViewState();
}

class _SmaGroupSettingsViewState extends State<SmaGroupSettingsView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String groupName = "Tech Innovators";
  String description = "A vibrant community for technology enthusiasts, innovators, and professionals who are passionate about the latest tech trends.";
  String category = "technology";
  String coverImage = "https://picsum.photos/400/200?random=1&keyword=technology";
  
  // Privacy Settings
  String privacy = "public";
  bool allowInvites = true;
  bool requireApproval = false;
  bool allowMemberPosts = true;
  bool allowFileSharing = true;
  bool allowPolls = true;
  bool allowEvents = true;
  bool autoApproveJoinRequests = false;
  bool allowMemberInvites = true;
  
  // Notification Settings
  bool notifyOnNewPosts = true;
  bool notifyOnNewMembers = true;
  bool notifyOnGroupUpdates = true;
  bool emailNotifications = false;
  bool pushNotifications = true;
  
  // Moderation Settings
  bool moderateAllPosts = false;
  bool filterProfanity = true;
  bool requirePhoneVerification = false;
  bool blockSpamUsers = true;
  String reportThreshold = "3";
  
  // Group Rules
  List<String> rules = [
    "Be respectful to all members",
    "No spam or self-promotion",
    "Stay on-topic with technology discussions",
    "Use appropriate language",
    "No sharing of pirated content"
  ];
  String newRule = "";
  
  // Tags
  List<String> tags = ["AI", "Programming", "Startup", "Innovation"];
  String newTag = "";
  
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

  List<Map<String, dynamic>> reportThresholdOptions = [
    {"label": "1 Report", "value": "1"},
    {"label": "3 Reports", "value": "3"},
    {"label": "5 Reports", "value": "5"},
    {"label": "10 Reports", "value": "10"},
  ];

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

  void _saveSettings() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    ss("Group settings updated successfully!");
  }

  void _deleteGroup() async {
    final confirmed = await confirm(
      "Are you sure you want to delete this group? This action cannot be undone and all group data will be permanently lost."
    );
    
    if (confirmed) {
      setState(() {
        isLoading = true;
      });

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });

      ss("Group deleted successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Settings"),
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
              onPressed: _saveSettings,
              child: Text(
                "Save",
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
              // Basic Information
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
                    
                    QImagePicker(
                      label: "Cover Image",
                      value: coverImage,
                      hint: "Update group cover image",
                      onChanged: (value) {
                        coverImage = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Group Name",
                      value: groupName,
                      hint: "Enter group name",
                      validator: Validator.required,
                      onChanged: (value) {
                        groupName = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe your group",
                      validator: Validator.required,
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Category",
                      items: categoryOptions,
                      value: category,
                      onChanged: (value, label) {
                        category = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Privacy Settings
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
                      "Privacy & Permissions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QDropdownField(
                      label: "Privacy Setting",
                      items: privacyOptions,
                      value: privacy,
                      onChanged: (value, label) {
                        privacy = value;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Allow member invites",
                          "value": "member_invites",
                          "checked": allowMemberInvites,
                        }
                      ],
                      value: [
                        if (allowMemberInvites) {
                          "label": "Allow member invites",
                          "value": "member_invites",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        allowMemberInvites = values.any((v) => v["value"] == "member_invites");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Require approval for new members",
                          "value": "require_approval",
                          "checked": requireApproval,
                        }
                      ],
                      value: [
                        if (requireApproval) {
                          "label": "Require approval for new members",
                          "value": "require_approval",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        requireApproval = values.any((v) => v["value"] == "require_approval");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Auto-approve join requests",
                          "value": "auto_approve",
                          "checked": autoApproveJoinRequests,
                        }
                      ],
                      value: [
                        if (autoApproveJoinRequests) {
                          "label": "Auto-approve join requests",
                          "value": "auto_approve",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        autoApproveJoinRequests = values.any((v) => v["value"] == "auto_approve");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Content Settings
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
                      "Content & Features",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Allow member posts",
                          "value": "member_posts",
                          "checked": allowMemberPosts,
                        }
                      ],
                      value: [
                        if (allowMemberPosts) {
                          "label": "Allow member posts",
                          "value": "member_posts",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        allowMemberPosts = values.any((v) => v["value"] == "member_posts");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Allow file sharing",
                          "value": "file_sharing",
                          "checked": allowFileSharing,
                        }
                      ],
                      value: [
                        if (allowFileSharing) {
                          "label": "Allow file sharing",
                          "value": "file_sharing",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        allowFileSharing = values.any((v) => v["value"] == "file_sharing");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Enable polls",
                          "value": "polls",
                          "checked": allowPolls,
                        }
                      ],
                      value: [
                        if (allowPolls) {
                          "label": "Enable polls",
                          "value": "polls",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        allowPolls = values.any((v) => v["value"] == "polls");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Enable events",
                          "value": "events",
                          "checked": allowEvents,
                        }
                      ],
                      value: [
                        if (allowEvents) {
                          "label": "Enable events",
                          "value": "events",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        allowEvents = values.any((v) => v["value"] == "events");
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
                      "Notifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Notify on new posts",
                          "value": "new_posts",
                          "checked": notifyOnNewPosts,
                        }
                      ],
                      value: [
                        if (notifyOnNewPosts) {
                          "label": "Notify on new posts",
                          "value": "new_posts",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        notifyOnNewPosts = values.any((v) => v["value"] == "new_posts");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Notify on new members",
                          "value": "new_members",
                          "checked": notifyOnNewMembers,
                        }
                      ],
                      value: [
                        if (notifyOnNewMembers) {
                          "label": "Notify on new members",
                          "value": "new_members",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        notifyOnNewMembers = values.any((v) => v["value"] == "new_members");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Email notifications",
                          "value": "email",
                          "checked": emailNotifications,
                        }
                      ],
                      value: [
                        if (emailNotifications) {
                          "label": "Email notifications",
                          "value": "email",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        emailNotifications = values.any((v) => v["value"] == "email");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Moderation Settings
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
                      "Moderation",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Moderate all posts",
                          "value": "moderate_posts",
                          "checked": moderateAllPosts,
                        }
                      ],
                      value: [
                        if (moderateAllPosts) {
                          "label": "Moderate all posts",
                          "value": "moderate_posts",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        moderateAllPosts = values.any((v) => v["value"] == "moderate_posts");
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Filter profanity",
                          "value": "filter_profanity",
                          "checked": filterProfanity,
                        }
                      ],
                      value: [
                        if (filterProfanity) {
                          "label": "Filter profanity",
                          "value": "filter_profanity",
                          "checked": true
                        }
                      ],
                      onChanged: (values, ids) {
                        filterProfanity = values.any((v) => v["value"] == "filter_profanity");
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Auto-ban threshold",
                      items: reportThresholdOptions,
                      value: reportThreshold,
                      onChanged: (value, label) {
                        reportThreshold = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Group Rules
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
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Add Rule",
                            value: newRule,
                            hint: "Enter a new rule",
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
              
              // Tags
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
              
              // Save Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: isLoading ? "Saving Changes..." : "Save Changes",
                  icon: isLoading ? null : Icons.save,
                  size: bs.md,
                  onPressed: isLoading ? null : _saveSettings,
                ),
              ),
              
              // Danger Zone
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: dangerColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Danger Zone",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Deleting a group is permanent and cannot be undone. All group data, posts, and member information will be lost.",
                      style: TextStyle(
                        fontSize: 13,
                        color: dangerColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Delete Group",
                        icon: Icons.delete_forever,
                        color: dangerColor,
                        size: bs.md,
                        onPressed: _deleteGroup,
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
