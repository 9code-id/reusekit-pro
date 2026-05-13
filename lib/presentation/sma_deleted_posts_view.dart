import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaDeletedPostsView extends StatefulWidget {
  const SmaDeletedPostsView({super.key});

  @override
  State<SmaDeletedPostsView> createState() => _SmaDeletedPostsViewState();
}

class _SmaDeletedPostsViewState extends State<SmaDeletedPostsView> {
  String searchQuery = "";
  List<String> selectedPosts = [];
  bool isSelectMode = false;

  List<Map<String, dynamic>> deletedPosts = [
    {
      "id": "1",
      "content": "Old photo from my college days. Decided to keep my timeline more current and professional.",
      "image": "https://picsum.photos/400/300?random=10&keyword=college",
      "likes": 23,
      "comments": 5,
      "shares": 2,
      "deleted_date": "2024-12-12",
      "original_date": "2019-05-20",
      "deletion_reason": "Personal cleanup",
      "days_until_permanent": 25,
    },
    {
      "id": "2",
      "content": "Rant about traffic this morning. Probably not the most positive content to share.",
      "image": null,
      "likes": 8,
      "comments": 12,
      "shares": 0,
      "deleted_date": "2024-12-10",
      "original_date": "2024-12-09",
      "deletion_reason": "Negative content",
      "days_until_permanent": 23,
    },
    {
      "id": "3",
      "content": "Shared a controversial article without reading it fully. Better to remove it to avoid misunderstandings.",
      "image": "https://picsum.photos/400/300?random=11&keyword=news",
      "likes": 15,
      "comments": 28,
      "shares": 4,
      "deleted_date": "2024-12-08",
      "original_date": "2024-12-07",
      "deletion_reason": "Controversial content",
      "days_until_permanent": 21,
    },
    {
      "id": "4",
      "content": "Posted duplicate content by mistake. This was the second copy.",
      "image": "https://picsum.photos/400/300?random=12&keyword=duplicate",
      "likes": 32,
      "comments": 7,
      "shares": 3,
      "deleted_date": "2024-12-05",
      "original_date": "2024-11-30",
      "deletion_reason": "Duplicate post",
      "days_until_permanent": 18,
    },
    {
      "id": "5",
      "content": "Accidentally posted a private message meant for a friend. Quickly deleted it.",
      "image": null,
      "likes": 2,
      "comments": 1,
      "shares": 0,
      "deleted_date": "2024-12-01",
      "original_date": "2024-12-01",
      "deletion_reason": "Posted by mistake",
      "days_until_permanent": 14,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    if (searchQuery.isEmpty) return deletedPosts;
    return deletedPosts.where((post) {
      return "${post["content"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${post["deletion_reason"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _toggleSelectMode() {
    isSelectMode = !isSelectMode;
    if (!isSelectMode) {
      selectedPosts.clear();
    }
    setState(() {});
  }

  void _togglePostSelection(String postId) {
    if (selectedPosts.contains(postId)) {
      selectedPosts.remove(postId);
    } else {
      selectedPosts.add(postId);
    }
    setState(() {});
  }

  void _restoreSelectedPosts() async {
    bool isConfirmed = await confirm("Restore ${selectedPosts.length} posts to your profile?");
    if (isConfirmed) {
      deletedPosts.removeWhere((post) => selectedPosts.contains(post["id"]));
      selectedPosts.clear();
      isSelectMode = false;
      setState(() {});
      ss("Posts restored successfully");
    }
  }

  void _permanentlyDeleteSelectedPosts() async {
    bool isConfirmed = await confirm("Permanently delete ${selectedPosts.length} posts? This action cannot be undone and they will be removed immediately.");
    if (isConfirmed) {
      deletedPosts.removeWhere((post) => selectedPosts.contains(post["id"]));
      selectedPosts.clear();
      isSelectMode = false;
      setState(() {});
      ss("Posts permanently deleted");
    }
  }

  Color _getDaysColor(int days) {
    if (days <= 7) return dangerColor;
    if (days <= 14) return warningColor;
    return successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deleted Posts"),
        actions: [
          if (isSelectMode && selectedPosts.isNotEmpty) ...[
            IconButton(
              icon: Icon(Icons.restore),
              onPressed: _restoreSelectedPosts,
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: _permanentlyDeleteSelectedPosts,
            ),
          ],
          IconButton(
            icon: Icon(isSelectMode ? Icons.close : Icons.checklist),
            onPressed: _toggleSelectMode,
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
              label: "Search deleted posts",
              value: searchQuery,
              hint: "Search by content or reason...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Deletion Policy Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule_outlined, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Deletion Policy",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Deleted posts are kept for 30 days before permanent removal. You can restore them anytime during this period.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Posts Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredPosts.length} Deleted Posts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isSelectMode)
                  Text(
                    "${selectedPosts.length} Selected",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),

            // Posts List
            if (filteredPosts.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      searchQuery.isEmpty ? "No Deleted Posts" : "No Posts Found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      searchQuery.isEmpty
                          ? "Posts you delete will appear here for 30 days"
                          : "Try adjusting your search terms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredPosts.map((post) {
                bool isSelected = selectedPosts.contains(post["id"]);
                int daysLeft = post["days_until_permanent"] as int;
                Color daysColor = _getDaysColor(daysLeft);
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isSelectMode && isSelected
                        ? Border.all(color: primaryColor, width: 2)
                        : Border.all(color: dangerColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            if (isSelectMode)
                              GestureDetector(
                                onTap: () => _togglePostSelection(post["id"]),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected ? primaryColor : disabledColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: isSelected
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                              ),
                            if (isSelectMode) SizedBox(width: spSm),
                            Icon(Icons.delete, color: dangerColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Deleted on ${DateTime.parse(post["deleted_date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Reason: ${post["deletion_reason"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Days until permanent deletion
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: daysColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: daysColor.withAlpha(40)),
                              ),
                              child: Text(
                                "${daysLeft}d left",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: daysColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Post Content
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Text(
                          "${post["content"]}",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.4,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),

                      // Post Image
                      if (post["image"] != null) ...[
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: EdgeInsets.symmetric(horizontal: spMd),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${post["image"]}"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withAlpha(50),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                        ),
                      ],

                      // Post Stats & Actions
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          spacing: spSm,
                          children: [
                            // Stats
                            Row(
                              children: [
                                Icon(Icons.favorite, color: disabledColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["likes"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.comment, color: disabledColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["comments"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.share, color: disabledColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${post["shares"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            // Action Buttons
                            if (!isSelectMode)
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Restore Post",
                                      icon: Icons.restore,
                                      size: bs.sm,
                                      onPressed: () async {
                                        bool isConfirmed = await confirm("Restore this post to your profile?");
                                        if (isConfirmed) {
                                          deletedPosts.removeWhere((p) => p["id"] == post["id"]);
                                          setState(() {});
                                          ss("Post restored successfully");
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.delete_forever,
                                    size: bs.sm,
                                    onPressed: () async {
                                      bool isConfirmed = await confirm("Permanently delete this post? This action cannot be undone.");
                                      if (isConfirmed) {
                                        deletedPosts.removeWhere((p) => p["id"] == post["id"]);
                                        setState(() {});
                                        ss("Post permanently deleted");
                                      }
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
