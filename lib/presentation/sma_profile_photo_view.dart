import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaProfilePhotoView extends StatefulWidget {
  const SmaProfilePhotoView({super.key});

  @override
  State<SmaProfilePhotoView> createState() => _SmaProfilePhotoViewState();
}

class _SmaProfilePhotoViewState extends State<SmaProfilePhotoView> {
  String profilePhoto = "";
  String coverPhoto = "";
  
  List<String> suggestedAvatars = [
    "https://picsum.photos/200/200?random=1&keyword=person",
    "https://picsum.photos/200/200?random=2&keyword=person",
    "https://picsum.photos/200/200?random=3&keyword=person",
    "https://picsum.photos/200/200?random=4&keyword=person",
    "https://picsum.photos/200/200?random=5&keyword=person",
    "https://picsum.photos/200/200?random=6&keyword=person",
    "https://picsum.photos/200/200?random=7&keyword=person",
    "https://picsum.photos/200/200?random=8&keyword=person",
  ];
  
  List<String> suggestedCovers = [
    "https://picsum.photos/400/200?random=1&keyword=nature",
    "https://picsum.photos/400/200?random=2&keyword=landscape",
    "https://picsum.photos/400/200?random=3&keyword=city",
    "https://picsum.photos/400/200?random=4&keyword=abstract",
    "https://picsum.photos/400/200?random=5&keyword=sunset",
    "https://picsum.photos/400/200?random=6&keyword=mountain",
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Photos"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProgressIndicator(),
            _buildProfilePreview(),
            _buildProfilePhotoSection(),
            _buildCoverPhotoSection(),
            _buildPhotoTips(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Setup Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Step 2 of 4",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfilePreview() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: coverPhoto.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(coverPhoto),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: coverPhoto.isEmpty ? primaryColor.withAlpha(50) : null,
            ),
            child: coverPhoto.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 40,
                          color: primaryColor,
                        ),
                        Text(
                          "Cover Photo",
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
          Transform.translate(
            offset: Offset(0, -40),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    image: profilePhoto.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(profilePhoto),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: profilePhoto.isEmpty ? primaryColor.withAlpha(50) : null,
                  ),
                  child: profilePhoto.isEmpty
                      ? Icon(
                          Icons.person,
                          size: 40,
                          color: primaryColor,
                        )
                      : null,
                ),
                SizedBox(height: spSm),
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Profile Preview",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfilePhotoSection() {
    return Container(
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
            "Profile Photo",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QImagePicker(
            label: "Upload Profile Photo",
            value: profilePhoto,
            hint: "Choose a clear photo of yourself",
            onChanged: (value) {
              profilePhoto = value;
              setState(() {});
            },
          ),
          Text(
            "Suggested Avatars",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: List.generate(suggestedAvatars.length, (index) {
              final avatar = suggestedAvatars[index];
              return GestureDetector(
                onTap: () {
                  profilePhoto = avatar;
                  setState(() {});
                },
                child: Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: profilePhoto == avatar ? primaryColor : disabledOutlineBorderColor,
                      width: profilePhoto == avatar ? 3 : 1,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCoverPhotoSection() {
    return Container(
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
            "Cover Photo",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QImagePicker(
            label: "Upload Cover Photo",
            value: coverPhoto,
            hint: "Choose a beautiful background image",
            onChanged: (value) {
              coverPhoto = value;
              setState(() {});
            },
          ),
          Text(
            "Suggested Covers",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: List.generate(suggestedCovers.length, (index) {
              final cover = suggestedCovers[index];
              return GestureDetector(
                onTap: () {
                  coverPhoto = cover;
                  setState(() {});
                },
                child: Container(
                  width: 120,
                  height: 70,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: coverPhoto == cover ? primaryColor : disabledOutlineBorderColor,
                      width: coverPhoto == cover ? 3 : 1,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(cover),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPhotoTips() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Photo Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          _buildTipItem("Use a clear, high-quality photo for your profile picture"),
          _buildTipItem("Choose a cover photo that represents your personality"),
          _buildTipItem("Make sure your face is clearly visible in the profile photo"),
          _buildTipItem("Avoid using copyrighted images as your cover photo"),
          _buildTipItem("Keep your photos appropriate and professional"),
        ],
      ),
    );
  }
  
  Widget _buildTipItem(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          color: infoColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              fontSize: 14,
              color: infoColor,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Continue",
            onPressed: () {
              ss("Photos uploaded successfully!");
              //navigateTo('InterestsSelectionView')
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Skip for Now",
            onPressed: () {
              //navigateTo('InterestsSelectionView')
            },
          ),
        ),
      ],
    );
  }
}
