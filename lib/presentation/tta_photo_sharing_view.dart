import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPhotoSharingView extends StatefulWidget {
  const TtaPhotoSharingView({super.key});

  @override
  State<TtaPhotoSharingView> createState() => _TtaPhotoSharingViewState();
}

class _TtaPhotoSharingViewState extends State<TtaPhotoSharingView> {
  String caption = "";
  String location = "";
  List<String> selectedPhotos = [];
  List<String> hashtags = [];
  String newHashtag = "";
  bool shareToFacebook = false;
  bool shareToInstagram = false;
  bool shareToTwitter = false;
  String privacy = "public";

  List<Map<String, dynamic>> recentPhotos = [
    {
      "id": "1",
      "url": "https://picsum.photos/300/300?random=1&keyword=travel",
      "caption": "Beautiful sunset at Bali Beach",
      "location": "Bali, Indonesia",
      "likes": 245,
      "comments": 18,
      "timestamp": "2 hours ago",
      "user": "john_traveler",
      "userAvatar": "https://picsum.photos/50/50?random=101&keyword=person",
    },
    {
      "id": "2",
      "url": "https://picsum.photos/300/300?random=2&keyword=mountain",
      "caption": "Amazing view from Mount Bromo",
      "location": "East Java, Indonesia",
      "likes": 892,
      "comments": 45,
      "timestamp": "1 day ago",
      "user": "adventure_sarah",
      "userAvatar": "https://picsum.photos/50/50?random=102&keyword=person",
    },
    {
      "id": "3",
      "url": "https://picsum.photos/300/300?random=3&keyword=food",
      "caption": "Delicious local cuisine",
      "location": "Yogyakarta, Indonesia",
      "likes": 156,
      "comments": 12,
      "timestamp": "3 days ago",
      "user": "foodie_mike",
      "userAvatar": "https://picsum.photos/50/50?random=103&keyword=person",
    },
    {
      "id": "4",
      "url": "https://picsum.photos/300/300?random=4&keyword=beach",
      "caption": "Crystal clear waters",
      "location": "Gili Islands, Indonesia",
      "likes": 634,
      "comments": 29,
      "timestamp": "5 days ago",
      "user": "beach_lover",
      "userAvatar": "https://picsum.photos/50/50?random=104&keyword=person",
    },
  ];

  List<Map<String, dynamic>> privacyOptions = [
    {"label": "Public", "value": "public"},
    {"label": "Friends Only", "value": "friends"},
    {"label": "Private", "value": "private"},
  ];

  void _addHashtag() {
    if (newHashtag.isNotEmpty && !hashtags.contains(newHashtag)) {
      hashtags.add(newHashtag);
      newHashtag = "";
      setState(() {});
    }
  }

  void _removeHashtag(String hashtag) {
    hashtags.remove(hashtag);
    setState(() {});
  }

  void _sharePost() async {
    if (selectedPhotos.isEmpty) {
      se("Please select at least one photo");
      return;
    }
    
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Photos shared successfully!");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Photos"),
        actions: [
          QButton(
            label: "Share",
            size: bs.sm,
            onPressed: _sharePost,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Photo Selection Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Select Photos",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (selectedPhotos.isNotEmpty) ...[
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedPhotos.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 80,
                            margin: EdgeInsets.only(right: spXs),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    selectedPhotos[index],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedPhotos.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  QButton(
                    label: "Add Photos",
                    icon: Icons.add_photo_alternate,
                    size: bs.sm,
                    onPressed: () {
                      // Simulate photo selection
                      selectedPhotos.add("https://picsum.photos/300/300?random=${selectedPhotos.length + 10}&keyword=travel");
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Caption Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Add Caption",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QMemoField(
                    label: "What's on your mind?",
                    value: caption,
                    hint: "Share your travel experience...",
                    onChanged: (value) {
                      caption = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Location Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Add Location",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Location",
                          value: location,
                          hint: "Where was this taken?",
                          onChanged: (value) {
                            location = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.my_location,
                        size: bs.sm,
                        onPressed: () {
                          location = "Current Location";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Hashtags Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.tag,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Hashtags",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Add hashtag",
                          value: newHashtag,
                          hint: "#travel #vacation #indonesia",
                          onChanged: (value) {
                            newHashtag = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Add",
                        size: bs.sm,
                        onPressed: _addHashtag,
                      ),
                    ],
                  ),
                  if (hashtags.isNotEmpty) ...[
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: hashtags.map((hashtag) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: primaryColor.withAlpha(50)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "#$hashtag",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () => _removeHashtag(hashtag),
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
                ],
              ),
            ),

            // Social Media Sharing
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
                  Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Share To",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Facebook",
                        "value": "facebook",
                        "checked": shareToFacebook,
                      },
                    ],
                    value: shareToFacebook ? [{"label": "Facebook", "value": "facebook", "checked": true}] : [],
                    onChanged: (values, ids) {
                      shareToFacebook = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Instagram",
                        "value": "instagram",
                        "checked": shareToInstagram,
                      },
                    ],
                    value: shareToInstagram ? [{"label": "Instagram", "value": "instagram", "checked": true}] : [],
                    onChanged: (values, ids) {
                      shareToInstagram = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Twitter",
                        "value": "twitter",
                        "checked": shareToTwitter,
                      },
                    ],
                    value: shareToTwitter ? [{"label": "Twitter", "value": "twitter", "checked": true}] : [],
                    onChanged: (values, ids) {
                      shareToTwitter = values.isNotEmpty;
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
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Privacy",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Who can see this?",
                    items: privacyOptions,
                    value: privacy,
                    onChanged: (value, label) {
                      privacy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Recent Shared Photos
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
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Shares",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...recentPhotos.map((photo) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${photo["url"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${photo["caption"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${photo["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          size: 12,
                                          color: dangerColor,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${photo["likes"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.comment,
                                          size: 12,
                                          color: infoColor,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${photo["comments"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "${photo["timestamp"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
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
          ],
        ),
      ),
    );
  }
}
