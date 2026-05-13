import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaRatingView extends StatefulWidget {
  const EmaRatingView({super.key});

  @override
  State<EmaRatingView> createState() => _EmaRatingViewState();
}

class _EmaRatingViewState extends State<EmaRatingView> {
  int currentTab = 0;
  double overallRating = 0.0;
  double serviceQuality = 0.0;
  double easeOfUse = 0.0;
  double reliability = 0.0;
  double valueForMoney = 0.0;
  String ratingComment = "";
  String selectedCategory = "Medical Equipment";
  bool isSubmitting = false;

  List<Map<String, dynamic>> ratingCategories = [
    {"label": "Medical Equipment", "value": "Medical Equipment"},
    {"label": "Healthcare Software", "value": "Healthcare Software"},
    {"label": "Hospital Services", "value": "Hospital Services"},
    {"label": "Training Program", "value": "Training Program"},
    {"label": "Research Tool", "value": "Research Tool"},
    {"label": "Mobile App", "value": "Mobile App"},
  ];

  List<Map<String, dynamic>> myRatings = [
    {
      "id": "rating_001",
      "productName": "AI Diagnostic Scanner Pro",
      "manufacturer": "MedTech Innovations",
      "category": "Medical Equipment",
      "overallRating": 4.5,
      "serviceQuality": 4.8,
      "easeOfUse": 4.2,
      "reliability": 4.6,
      "valueForMoney": 4.3,
      "comment": "Excellent diagnostic capabilities and user-friendly interface. Highly recommended for radiology departments.",
      "ratingDate": "2024-03-15",
      "helpful": 12,
    },
    {
      "id": "rating_002",
      "productName": "HealthFlow EHR System",
      "manufacturer": "Digital Health Solutions",
      "category": "Healthcare Software",
      "overallRating": 3.8,
      "serviceQuality": 4.0,
      "easeOfUse": 3.5,
      "reliability": 4.1,
      "valueForMoney": 3.6,
      "comment": "Good functionality but could benefit from better user interface design. Integration works well.",
      "ratingDate": "2024-03-10",
      "helpful": 8,
    },
    {
      "id": "rating_003",
      "productName": "TeleCare Remote Monitoring",
      "manufacturer": "Remote Health Inc.",
      "category": "Healthcare Software",
      "overallRating": 4.7,
      "serviceQuality": 4.9,
      "easeOfUse": 4.6,
      "reliability": 4.8,
      "valueForMoney": 4.5,
      "comment": "Outstanding platform for remote patient care. Reliable connectivity and comprehensive monitoring features.",
      "ratingDate": "2024-03-05",
      "helpful": 18,
    },
  ];

  List<Map<String, dynamic>> communityRatings = [
    {
      "id": "cr_001",
      "productName": "SmartSurgery Robot Assistant",
      "manufacturer": "Precision Robotics Ltd",
      "category": "Medical Equipment",
      "rater": "Dr. Michael Chen",
      "raterRole": "Chief Surgeon",
      "hospital": "Metropolitan Medical Center",
      "overallRating": 4.9,
      "serviceQuality": 4.8,
      "easeOfUse": 4.7,
      "reliability": 5.0,
      "valueForMoney": 4.6,
      "comment": "Revolutionary technology that has transformed our surgical precision. Exceptional reliability and support.",
      "ratingDate": "2024-03-16",
      "helpful": 45,
      "verified": true,
    },
    {
      "id": "cr_002",
      "productName": "VitalSign Monitor Pro",
      "manufacturer": "Patient Care Systems",
      "category": "Medical Equipment",
      "rater": "Linda Thompson, RN",
      "raterRole": "ICU Head Nurse",
      "hospital": "General Hospital Network",
      "overallRating": 4.3,
      "serviceQuality": 4.1,
      "easeOfUse": 4.5,
      "reliability": 4.4,
      "valueForMoney": 4.2,
      "comment": "Reliable monitoring with excellent alarm systems. Easy to use during critical care situations.",
      "ratingDate": "2024-03-14",
      "helpful": 32,
      "verified": true,
    },
    {
      "id": "cr_003",
      "productName": "MedData Analytics Platform",
      "manufacturer": "HealthTech Analytics",
      "category": "Healthcare Software",
      "rater": "Dr. Sarah Williams",
      "raterRole": "Data Analyst",
      "hospital": "Research Medical Institute",
      "overallRating": 4.0,
      "serviceQuality": 3.8,
      "easeOfUse": 4.2,
      "reliability": 4.1,
      "valueForMoney": 3.9,
      "comment": "Powerful analytics capabilities with comprehensive reporting features. Learning curve is moderate.",
      "ratingDate": "2024-03-12",
      "helpful": 23,
      "verified": false,
    },
  ];

  List<Map<String, dynamic>> topRatedProducts = [
    {
      "name": "AI Pathology Assistant",
      "manufacturer": "DiagnosticAI Corp",
      "category": "Healthcare Software",
      "overallRating": 4.8,
      "totalRatings": 156,
      "serviceQuality": 4.7,
      "easeOfUse": 4.6,
      "reliability": 4.9,
      "valueForMoney": 4.5,
      "image": "https://picsum.photos/80/80?random=1&keyword=medical",
    },
    {
      "name": "Portable Ultrasound Elite",
      "manufacturer": "UltraSound Innovations",
      "category": "Medical Equipment",
      "overallRating": 4.7,
      "totalRatings": 134,
      "serviceQuality": 4.8,
      "easeOfUse": 4.5,
      "reliability": 4.8,
      "valueForMoney": 4.4,
      "image": "https://picsum.photos/80/80?random=2&keyword=ultrasound",
    },
    {
      "name": "Patient Management Suite",
      "manufacturer": "Healthcare IT Solutions",
      "category": "Healthcare Software",
      "overallRating": 4.6,
      "totalRatings": 198,
      "serviceQuality": 4.5,
      "easeOfUse": 4.7,
      "reliability": 4.6,
      "valueForMoney": 4.5,
      "image": "https://picsum.photos/80/80?random=3&keyword=software",
    },
  ];

  void _submitRating() {
    if (overallRating == 0.0) {
      se("Please provide an overall rating");
      return;
    }

    isSubmitting = true;
    setState(() {});

    // Simulate submission
    Future.delayed(Duration(seconds: 2), () {
      isSubmitting = false;
      overallRating = 0.0;
      serviceQuality = 0.0;
      easeOfUse = 0.0;
      reliability = 0.0;
      valueForMoney = 0.0;
      ratingComment = "";
      setState(() {});
      ss("Rating submitted successfully!");
    });
  }

  void _markHelpful(String ratingId) {
    ss("Thank you for marking this rating as helpful!");
  }

  Widget _buildStarRating(double rating, {double size = 16, bool interactive = false, Function(double)? onRatingChanged}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: interactive ? () => onRatingChanged?.call((index + 1).toDouble()) : null,
          child: Icon(
            index < rating.floor() 
                ? Icons.star
                : (index < rating && rating % 1 != 0)
                    ? Icons.star_half
                    : Icons.star_border,
            size: size,
            color: warningColor,
          ),
        );
      }),
    );
  }

  Widget _buildRatingBar(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              value > 0 ? value.toStringAsFixed(1) : "0.0",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: warningColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        _buildStarRating(
          value,
          size: 24,
          interactive: true,
          onRatingChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Rating System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Rate Product", icon: Icon(Icons.star_rate)),
        Tab(text: "My Ratings", icon: Icon(Icons.star)),
        Tab(text: "Community", icon: Icon(Icons.people)),
        Tab(text: "Top Rated", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildRateProductTab(),
        _buildMyRatingsTab(),
        _buildCommunityTab(),
        _buildTopRatedTab(),
      ],
    );
  }

  Widget _buildRateProductTab() {
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
                  Icons.star_rate,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spMd),
                Text(
                  "Rate Healthcare Products",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Share your experience and help healthcare professionals make informed decisions",
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

          // Rating Form
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
                  "Product Rating",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QDropdownField(
                  label: "Product Category",
                  items: ratingCategories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),

                // Overall Rating
                _buildRatingBar("Overall Rating", overallRating, (value) {
                  overallRating = value;
                  setState(() {});
                }),

                SizedBox(height: spMd),

                // Detailed Ratings
                Text(
                  "Detailed Ratings",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),

                _buildRatingBar("Service Quality", serviceQuality, (value) {
                  serviceQuality = value;
                  setState(() {});
                }),

                SizedBox(height: spMd),

                _buildRatingBar("Ease of Use", easeOfUse, (value) {
                  easeOfUse = value;
                  setState(() {});
                }),

                SizedBox(height: spMd),

                _buildRatingBar("Reliability", reliability, (value) {
                  reliability = value;
                  setState(() {});
                }),

                SizedBox(height: spMd),

                _buildRatingBar("Value for Money", valueForMoney, (value) {
                  valueForMoney = value;
                  setState(() {});
                }),

                SizedBox(height: spMd),

                QMemoField(
                  label: "Additional Comments",
                  value: ratingComment,
                  hint: "Share specific details about your experience with this product",
                  onChanged: (value) {
                    ratingComment = value;
                    setState(() {});
                  },
                ),

                SizedBox(height: spSm),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isSubmitting ? "Submitting..." : "Submit Rating",
                    icon: isSubmitting ? Icons.upload : Icons.send,
                    size: bs.md,
                    onPressed: isSubmitting ? null : _submitRating,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Rating Guidelines
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
                      "Rating Guidelines",
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
                  "• Rate based on your actual experience\n• Consider effectiveness, usability, and impact\n• Be objective and constructive\n• Include context about your use case\n• Maintain professional standards",
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

  Widget _buildMyRatingsTab() {
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
                        Icon(Icons.star_rate, color: primaryColor, size: 24),
                        Spacer(),
                        Text(
                          "${myRatings.length}",
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
                      "Total Ratings",
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
                          "${(myRatings.fold(0.0, (sum, rating) => sum + (rating["overallRating"] as double)) / myRatings.length).toStringAsFixed(1)}",
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
                          "${myRatings.fold(0, (sum, rating) => sum + (rating["helpful"] as int))}",
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

          // My Ratings List
          Text(
            "My Ratings History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...myRatings.map((rating) => Container(
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
                        "${rating["productName"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _buildStarRating(rating["overallRating"] as double),
                        SizedBox(width: spSm),
                        Text(
                          "${(rating["overallRating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${rating["manufacturer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${rating["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${rating["ratingDate"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                // Detailed ratings
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Column(
                      children: [
                        Text("Service Quality", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["serviceQuality"] as double, size: 12),
                        Text("${(rating["serviceQuality"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Ease of Use", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["easeOfUse"] as double, size: 12),
                        Text("${(rating["easeOfUse"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Reliability", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["reliability"] as double, size: 12),
                        Text("${(rating["reliability"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Value for Money", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["valueForMoney"] as double, size: 12),
                        Text("${(rating["valueForMoney"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${rating["comment"]}",
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
                      "${rating["helpful"]} helpful",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        //navigateTo edit rating
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
            "Community Ratings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...communityRatings.map((rating) => Container(
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
                          "${rating["rater"].toString().split(' ').map((e) => e[0]).take(2).join()}",
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
                                "${rating["rater"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if (rating["verified"] == true) ...[
                                SizedBox(width: spXs),
                                Icon(Icons.verified, size: 12, color: successColor),
                              ],
                            ],
                          ),
                          Text(
                            "${rating["raterRole"]} • ${rating["hospital"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${rating["ratingDate"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${rating["productName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${rating["manufacturer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildStarRating(rating["overallRating"] as double),
                    SizedBox(width: spSm),
                    Text(
                      "${(rating["overallRating"] as double).toStringAsFixed(1)}",
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
                        "${rating["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                // Detailed ratings
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Column(
                      children: [
                        Text("Service Quality", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["serviceQuality"] as double, size: 12),
                        Text("${(rating["serviceQuality"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Ease of Use", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["easeOfUse"] as double, size: 12),
                        Text("${(rating["easeOfUse"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Reliability", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["reliability"] as double, size: 12),
                        Text("${(rating["reliability"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Value for Money", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(rating["valueForMoney"] as double, size: 12),
                        Text("${(rating["valueForMoney"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${rating["comment"]}",
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
                      onTap: () => _markHelpful(rating["id"]),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up, size: 16, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "Helpful (${rating["helpful"]})",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        //navigateTo full rating details
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

  Widget _buildTopRatedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Rated Products",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...topRatedProducts.map((product) => Container(
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
                              _buildStarRating(product["overallRating"] as double),
                              SizedBox(width: spSm),
                              Text(
                                "${(product["overallRating"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "(${product["totalRatings"]} ratings)",
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
                  ],
                ),
                SizedBox(height: spMd),
                // Detailed ratings breakdown
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Column(
                      children: [
                        Text("Service Quality", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(product["serviceQuality"] as double, size: 12),
                        Text("${(product["serviceQuality"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Ease of Use", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(product["easeOfUse"] as double, size: 12),
                        Text("${(product["easeOfUse"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Reliability", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(product["reliability"] as double, size: 12),
                        Text("${(product["reliability"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Value for Money", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(height: spXs),
                        _buildStarRating(product["valueForMoney"] as double, size: 12),
                        Text("${(product["valueForMoney"] as double).toStringAsFixed(1)}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: warningColor)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo product details
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),

          SizedBox(height: spLg),

          // Rating Statistics Summary
          Text(
            "Rating Statistics",
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
                        Icon(Icons.star, color: warningColor, size: 24),
                        Spacer(),
                        Text(
                          "4.6",
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
                        Icon(Icons.assessment, color: infoColor, size: 24),
                        Spacer(),
                        Text(
                          "2,847",
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
                      "Total Ratings",
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
                        Icon(Icons.trending_up, color: successColor, size: 24),
                        Spacer(),
                        Text(
                          "78%",
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
                      "4+ Star Ratings",
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
