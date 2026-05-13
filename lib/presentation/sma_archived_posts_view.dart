import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaArchivedPostsView extends StatefulWidget {
  const SmaArchivedPostsView({super.key});

  @override
  State<SmaArchivedPostsView> createState() => _SmaArchivedPostsViewState();
}

class _SmaArchivedPostsViewState extends State<SmaArchivedPostsView> {
  String searchQuery = "";
  List<String> selectedPosts = [];
  bool isSelectMode = false;

  List<Map<String, dynamic>> archivedPosts = [
    {
      "id": "1",
      "content": "Just finished reading an amazing book about mindfulness. It completely changed my perspective on daily stress management.",
      "image": "https://picsum.photos/400/300?random=1&keyword=book",
      "likes": 45,
      "comments": 12,
      "shares": 8,
      "archived_date": "2024-12-10",
      "original_date": "2024-11-15",
    },
    {
      "id": "2",
      "content": "Sunset from my balcony tonight. Sometimes the simplest moments bring the most joy.",
      "image": "https://picsum.photos/400/300?random=2&keyword=sunset",
      "likes": 89,
      "comments": 23,
      "shares": 15,
      "archived_date": "2024-12-08",
      "original_date": "2024-11-10",
    },
    {
      "id": "3",
      "content": "Homemade pasta night! Recipe passed down from my grandmother. The secret ingredient is always love.",
      "image": "https://picsum.photos/400/300?random=3&keyword=pasta",
      "likes": 67,
      "comments": 18,
      "shares": 9,
      "archived_date": "2024-12-05",
      "original_date": "2024-11-08",
    },
    {
      "id": "4",
      "content": "Morning hike in the mountains. Fresh air and beautiful views are the perfect way to start the weekend.",
      "image": "https://picsum.photos/400/300?random=4&keyword=mountain",
      "likes": 102,
      "comments": 31,
      "shares": 22,
      "archived_date": "2024-12-01",
      "original_date": "2024-11-03",
    },
    {
      "id": "5",
      "content": "Coffee shop discovery! This little place has the most incredible lavender latte I've ever tasted.",
      "image": "https://picsum.photos/400/300?random=5&keyword=coffee",
      "likes": 54,
      "comments": 16,
      "shares": 7,
      "archived_date": "2024-11-28",
      "original_date": "2024-10-25",
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    if (searchQuery.isEmpty) return archivedPosts;
    return archivedPosts.where((post) {
      return "${post["content"]}".toLowerCase().contains(searchQuery.toLowerCase());
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
      archivedPosts.removeWhere((post) => selectedPosts.contains(post["id"]));
      selectedPosts.clear();
      isSelectMode = false;
      setState(() {});
      ss("Posts restored successfully");
    }
  }

  void _deleteSelectedPosts() async {
    bool isConfirmed = await confirm("Permanently delete ${selectedPosts.length} posts? This action cannot be undone.");
    if (isConfirmed) {
      archivedPosts.removeWhere((post) => selectedPosts.contains(post["id"]));
      selectedPosts.clear();
      isSelectMode = false;
      setState(() {});
      ss("Posts deleted successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Archived Posts"),
        actions: [
          if (isSelectMode && selectedPosts.isNotEmpty) ...[
            IconButton(
              icon: Icon(Icons.unarchive),
              onPressed: _restoreSelectedPosts,
            ),
            IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: _deleteSelectedPosts,
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
              label: "Search archived posts",
              value: searchQuery,
              hint: "Search by content...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Archive Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Archive Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Archived posts are hidden from your profile but saved here. You can restore them anytime or delete them permanently.",
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
                  "${filteredPosts.length} Archived Posts",
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
                      Icons.archive_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      searchQuery.isEmpty ? "No Archived Posts" : "No Posts Found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      searchQuery.isEmpty
                          ? "Posts you archive will appear here"
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
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isSelectMode && isSelected
                        ? Border.all(color: primaryColor, width: 2)
                        : null,
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
                            Icon(Icons.archive, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Archived on ${DateTime.parse(post["archived_date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Originally posted ${DateTime.parse(post["original_date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isSelectMode)
                              PopupMenuButton(
                                icon: Icon(Icons.more_vert, color: disabledBoldColor),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Icon(Icons.unarchive, size: 20),
                                        SizedBox(width: spSm),
                                        Text("Restore Post"),
                                      ],
                                    ),
                                    onTap: () async {
                                      bool isConfirmed = await confirm("Restore this post to your profile?");
                                      if (isConfirmed) {
                                        archivedPosts.removeWhere((p) => p["id"] == post["id"]);
                                        setState(() {});
                                        ss("Post restored successfully");
                                      }
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_forever, size: 20, color: dangerColor),
                                        SizedBox(width: spSm),
                                        Text("Delete Permanently", style: TextStyle(color: dangerColor)),
                                      ],
                                    ),
                                    onTap: () async {
                                      bool isConfirmed = await confirm("Permanently delete this post? This action cannot be undone.");
                                      if (isConfirmed) {
                                        archivedPosts.removeWhere((p) => p["id"] == post["id"]);
                                        setState(() {});
                                        ss("Post deleted successfully");
                                      }
                                    },
                                  ),
                                ],
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
                            ),
                          ),
                        ),
                      ],

                      // Post Stats
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Icon(Icons.favorite, color: dangerColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${post["likes"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.comment, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${post["comments"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.share, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${post["shares"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
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
