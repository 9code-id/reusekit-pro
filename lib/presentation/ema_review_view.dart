import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaReviewView extends StatefulWidget {
  const EmaReviewView({super.key});

  @override
  State<EmaReviewView> createState() => _EmaReviewViewState();
}

class _EmaReviewViewState extends State<EmaReviewView> {
  int currentTab = 0;
  String reviewTitle = "";
  String reviewContent = "";
  double rating = 5.0;
  String selectedCategory = "Medical Equipment";
  bool isSubmitting = false;
  bool isAnonymous = false;

  List<Map<String, dynamic>> reviewCategories = [
    {"label": "Medical Equipment", "value": "Medical Equipment"},
    {"label": "Healthcare Software", "value": "Healthcare Software"},
    {"label": "Hospital Services", "value": "Hospital Services"},
    {"label": "Medical Procedures", "value": "Medical Procedures"},
    {"label": "Training Programs", "value": "Training Programs"},
    {"label": "Research Papers", "value": "Research Papers"},
    {"label": "Healthcare Apps", "value": "Healthcare Apps"},
  ];

  List<Map<String, dynamic>> myReviews = [
    {
      "id": "rev_001",
      "title": "AI-Powered MRI Scanner Review",
      "category": "Medical Equipment",
      "rating": 4.5,
      "content": "The new AI-powered MRI scanner significantly reduces scan time while maintaining excellent image quality. The automated positioning feature is particularly helpful for elderly patients.",
      "submittedDate": "2024-03-15",
      "helpful": 23,
      "reported": 0,
      "status": "Published",
      "productName": "ScanMaster AI Pro 3000",
      "manufacturer": "MedTech Innovations",
    },
    {
      "id": "rev_002",
      "title": "Electronic Health Record System Evaluation",
      "category": "Healthcare Software",
      "rating": 3.8,
      "content": "The EHR system has improved our workflow efficiency, but the user interface could be more intuitive. Integration with existing lab systems works well.",
      "submittedDate": "2024-03-10",
      "helpful": 15,
      "reported": 1,
      "status": "Published",
      "productName": "HealthFlow EHR Suite",
      "manufacturer": "Digital Health Solutions",
    },
    {
      "id": "rev_003",
      "title": "Telemedicine Platform Assessment",
      "category": "Healthcare Apps",
      "rating": 4.8,
      "content": "Outstanding platform for remote patient consultations. Video quality is excellent and the scheduling system is very user-friendly. Highly recommended for practices transitioning to telehealth.",
      "submittedDate": "2024-03-05",
      "helpful": 31,
      "reported": 0,
      "status": "Published",
      "productName": "TeleCare Connect",
      "manufacturer": "Remote Health Inc.",
    },
  ];

  List<Map<String, dynamic>> communityReviews = [
    {
      "id": "cr_001",
      "title": "Revolutionary Surgical Robot Experience",
      "author": "Dr. James Wilson",
      "authorRole": "Chief of Surgery",
      "hospital": "Metropolitan Medical Center",
      "category": "Medical Equipment",
      "rating": 4.9,
      "content": "This surgical robot has transformed our minimally invasive procedures. The precision and control are exceptional, leading to better patient outcomes and reduced recovery times.",
      "submittedDate": "2024-03-16",
      "helpful": 67,
      "reported": 0,
      "productName": "RoboSurgeon X7",
      "manufacturer": "Advanced Surgical Systems",
      "verified": true,
    },
    {
      "id": "cr_002",
      "title": "Comprehensive Hospital Management System",
      "author": "Sarah Martinez, RN",
      "authorRole": "IT Director",
      "hospital": "Regional Healthcare Network",
      "category": "Healthcare Software",
      "rating": 4.2,
      "content": "The HMS has streamlined our administrative processes significantly. Patient flow management and bed allocation features are particularly impressive. Some modules need improvement.",
      "submittedDate": "2024-03-14",
      "helpful": 43,
      "reported": 0,
      "productName": "HospitalPro Management Suite",
      "manufacturer": "Healthcare IT Corp",
      "verified": true,
    },
    {
      "id": "cr_003",
      "title": "Portable Ultrasound Device Review",
      "author": "Dr. Emily Chen",
      "authorRole": "Emergency Medicine",
      "hospital": "City General Hospital",
      "category": "Medical Equipment",
      "rating": 4.6,
      "content": "Excellent portable ultrasound for emergency department use. Image quality rivals traditional units. Battery life could be longer for extended shifts.",
      "submittedDate": "2024-03-12",
      "helpful": 29,
      "reported": 0,
      "productName": "UltraScan Portable Pro",
      "manufacturer": "Diagnostic Devices Ltd",
      "verified": false,
    },
  ];

  List<Map<String, dynamic>> popularProducts = [
    {
      "name": "AI Diagnostic Assistant",
      "manufacturer": "TechMed Solutions",
      "category": "Healthcare Software",
      "averageRating": 4.7,
      "totalReviews": 234,
      "image": "https://picsum.photos/100/100?random=1&keyword=medical",
    },
    {
      "name": "Smart Patient Monitor",
      "manufacturer": "MedDevice Corp",
      "category": "Medical Equipment",
      "averageRating": 4.5,
      "totalReviews": 189,
      "image": "https://picsum.photos/100/100?random=2&keyword=monitor",
    },
    {
      "name": "Rehabilitation VR System",
      "manufacturer": "VirtTherapy Inc",
      "category": "Medical Equipment",
      "averageRating": 4.3,
      "totalReviews": 156,
      "image": "https://picsum.photos/100/100?random=3&keyword=vr",
    },
  ];

  void _submitReview() {
    if (reviewTitle.isEmpty || reviewContent.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    isSubmitting = true;
    setState(() {});

    // Simulate submission
    Future.delayed(Duration(seconds: 2), () {
      isSubmitting = false;
      reviewTitle = "";
      reviewContent = "";
      rating = 5.0;
      isAnonymous = false;
      setState(() {});
      ss("Review submitted successfully!");
    });
  }

  void _markHelpful(String reviewId) {
    ss("Thank you for marking this review as helpful!");
  }

  Widget _buildStarRating(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() 
              ? Icons.star
              : (index < rating && rating % 1 != 0)
                  ? Icons.star_half
                  : Icons.star_border,
          size: size,
          color: warningColor,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reviews & Ratings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Write Review", icon: Icon(Icons.rate_review)),
        Tab(text: "My Reviews", icon: Icon(Icons.list)),
        Tab(text: "Community", icon: Icon(Icons.group)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildWriteReviewTab(),
        _buildMyReviewsTab(),
        _buildCommunityTab(),
        _buildTrendingTab(),
      ],
    );
  }

  Widget _buildWriteReviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.rate_review,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spMd),
                Text(
                  "Share Your Experience",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Help the healthcare community by sharing honest reviews of medical equipment, software, and services",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Review Form
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Review Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QTextField(
                  label: "Review Title",
                  value: reviewTitle,
                  hint: "Brief, descriptive title for your review",
                  onChanged: (value) {
                    reviewTitle = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Category",
                  items: reviewCategories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),

                // Rating Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Rating",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {
                                rating = (index + 1).toDouble();
                                setState(() {});
                              },
                              child: Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                size: 32,
                                color: warningColor,
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "${rating.toStringAsFixed(1)} stars",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                QMemoField(
                  label: "Detailed Review",
                  value: reviewContent,
                  hint: "Share your experience, pros and cons, and recommendations for other healthcare professionals",
                  onChanged: (value) {
                    reviewContent = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Submit Anonymously",
                            "value": true,
                            "checked": isAnonymous,
                          }
                        ],
                        value: [
                          if (isAnonymous)
                            {
                              "label": "Submit Anonymously",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isAnonymous = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isSubmitting ? "Submitting..." : "Submit Review",
                    icon: isSubmitting ? Icons.upload : Icons.send,
                    size: bs.md,
                    onPressed: isSubmitting ? null : _submitReview,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Review Guidelines
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Review Guidelines",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Focus on your actual experience with the product or service\n• Be specific about pros and cons\n• Mention your role and use case context\n• Keep reviews professional and constructive\n• Avoid sharing sensitive patient information",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyReviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.rate_review, color: primaryColor, size: 24),
                        Spacer(),
                        Text(
                          "${myReviews.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Total Reviews",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 24),
                        Spacer(),
                        Text(
                          "${(myReviews.fold(0.0, (sum, review) => sum + (review["rating"] as double)) / myReviews.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Average Rating",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up, color: successColor, size: 24),
                        Spacer(),
                        Text(
                          "${myReviews.fold(0, (sum, review) => sum + (review["helpful"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Helpful Votes",
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

          SizedBox(height: spLg),

          // My Reviews List
          Text(
            "My Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...myReviews.map((review) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${review["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${review["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildStarRating(review["rating"] as double),
                    SizedBox(width: spSm),
                    Text(
                      "${(review["rating"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${review["category"]}",
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
                  "${review["productName"]} by ${review["manufacturer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${review["content"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: 16, color: successColor),
                    SizedBox(width: spXs),
                    Text(
                      "${review["helpful"]} helpful",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.calendar_today, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${review["submittedDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        //navigateTo edit review
                      },
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildCommunityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Community Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...communityReviews.map((review) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Center(
                        child: Text(
                          "${review["author"].toString().split(' ').map((e) => e[0]).take(2).join()}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${review["author"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if (review["verified"] == true) ...[
                                SizedBox(width: spXs),
                                Icon(Icons.verified, size: 12, color: successColor),
                              ],
                            ],
                          ),
                          Text(
                            "${review["authorRole"]} • ${review["hospital"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${review["submittedDate"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${review["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildStarRating(review["rating"] as double),
                    SizedBox(width: spSm),
                    Text(
                      "${(review["rating"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${review["category"]}",
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
                  "${review["productName"]} by ${review["manufacturer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${review["content"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Divider(color: disabledOutlineBorderColor),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _markHelpful(review["id"]),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up, size: 16, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "Helpful (${review["helpful"]})",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Row(
                      children: [
                        Icon(Icons.comment, size: 16, color: infoColor),
                        SizedBox(width: spXs),
                        Text(
                          "Comment",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        //navigateTo full review
                      },
                      child: Icon(
                        Icons.more_horiz,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Products
          Text(
            "Trending Products",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...popularProducts.map((product) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${product["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${product["manufacturer"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          _buildStarRating(product["averageRating"] as double),
                          SizedBox(width: spSm),
                          Text(
                            "${(product["averageRating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "(${product["totalReviews"]} reviews)",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${product["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //navigateTo product reviews
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )).toList(),

          SizedBox(height: spLg),

          // Rating Statistics
          Text(
            "Rating Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text("Rating", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor)),
                    Spacer(),
                    Text("Distribution", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor)),
                    SizedBox(width: spLg),
                    Text("Count", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor)),
                  ],
                ),
                Divider(color: disabledOutlineBorderColor),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("5", style: TextStyle(fontSize: 12, color: primaryColor)),
                        SizedBox(width: spXs),
                        Icon(Icons.star, size: 12, color: warningColor),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.65,
                          child: Container(
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text("156", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("4", style: TextStyle(fontSize: 12, color: primaryColor)),
                        SizedBox(width: spXs),
                        Icon(Icons.star, size: 12, color: warningColor),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.45,
                          child: Container(
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text("89", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("3", style: TextStyle(fontSize: 12, color: primaryColor)),
                        SizedBox(width: spXs),
                        Icon(Icons.star, size: 12, color: warningColor),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: infoColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text("34", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("2", style: TextStyle(fontSize: 12, color: primaryColor)),
                        SizedBox(width: spXs),
                        Icon(Icons.star, size: 12, color: warningColor),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.15,
                          child: Container(
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text("12", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("1", style: TextStyle(fontSize: 12, color: primaryColor)),
                        SizedBox(width: spXs),
                        Icon(Icons.star, size: 12, color: warningColor),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.08,
                          child: Container(
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text("7", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Review Categories
          Text(
            "Popular Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medical_services, color: primaryColor, size: 24),
                        Spacer(),
                        Text(
                          "234",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Medical Equipment",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.computer, color: infoColor, size: 24),
                        Spacer(),
                        Text(
                          "189",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Healthcare Software",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_hospital, color: successColor, size: 24),
                        Spacer(),
                        Text(
                          "156",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Hospital Services",
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
        ],
      ),
    );
  }
}
