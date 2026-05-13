import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDeliveryPhotoView extends StatefulWidget {
  const FdaDeliveryPhotoView({super.key});

  @override
  State<FdaDeliveryPhotoView> createState() => _FdaDeliveryPhotoViewState();
}

class _FdaDeliveryPhotoViewState extends State<FdaDeliveryPhotoView> {
  List<String> deliveryPhotos = [
    "https://picsum.photos/300/400?random=1&keyword=delivery",
    "https://picsum.photos/300/400?random=2&keyword=package",
    "https://picsum.photos/300/400?random=3&keyword=food",
  ];

  int selectedPhotoIndex = 0;
  bool photoVerified = true;
  String deliveryNote = "";
  
  Map<String, dynamic> deliveryInfo = {
    "orderId": "#FDA12345",
    "deliveryTime": "2:45 PM",
    "deliveryDate": "Today",
    "deliveryPerson": "John Smith",
    "deliveryPersonPhone": "+1 (555) 123-4567",
    "deliveryAddress": "123 Main St, Apt 4B",
    "deliveryInstructions": "Leave at the door",
    "estimatedDeliveryTime": "2:30 PM - 2:50 PM",
    "actualDeliveryTime": "2:45 PM",
    "deliveryStatus": "Delivered",
    "customerRating": 0,
  };

  List<Map<String, dynamic>> photoDetails = [
    {
      "title": "Package at Door",
      "description": "Food package safely delivered at your doorstep",
      "timestamp": "2:45 PM",
      "location": "Front Door",
    },
    {
      "title": "Order Contents",
      "description": "All items included as per your order",
      "timestamp": "2:45 PM", 
      "location": "Package View",
    },
    {
      "title": "Delivery Confirmation",
      "description": "Order successfully delivered and secured",
      "timestamp": "2:46 PM",
      "location": "Confirmation Shot",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Photos"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareDeliveryPhotos();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _downloadPhotos();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Status Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ${deliveryInfo["orderId"]} Delivered",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Delivered at ${deliveryInfo["deliveryTime"]} • ${deliveryInfo["deliveryDate"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Photo Gallery
            Text(
              "Delivery Photos",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Photos taken by your delivery person for verification",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),

            SizedBox(height: spMd),

            // Main Photo Display
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      deliveryPhotos[selectedPhotoIndex],
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  // Photo Navigation
                  if (deliveryPhotos.length > 1) ...[
                    if (selectedPhotoIndex > 0) ...[
                      Positioned(
                        left: spMd,
                        top: 180,
                        child: GestureDetector(
                          onTap: () {
                            selectedPhotoIndex--;
                            setState(() {});
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(128),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (selectedPhotoIndex < deliveryPhotos.length - 1) ...[
                      Positioned(
                        right: spMd,
                        top: 180,
                        child: GestureDetector(
                          onTap: () {
                            selectedPhotoIndex++;
                            setState(() {});
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(128),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],

                  // Photo Info Overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(179),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusMd),
                          bottomRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${photoDetails[selectedPhotoIndex]["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${photoDetails[selectedPhotoIndex]["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.white.withAlpha(204),
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${photoDetails[selectedPhotoIndex]["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(204),
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(
                                Icons.location_on,
                                color: Colors.white.withAlpha(204),
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${photoDetails[selectedPhotoIndex]["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(204),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Photo Counter
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(128),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${selectedPhotoIndex + 1} / ${deliveryPhotos.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Verified Badge
                  if (photoVerified) ...[
                    Positioned(
                      top: spMd,
                      left: spMd,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "VERIFIED",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Photo Thumbnails
            if (deliveryPhotos.length > 1) ...[
              Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: deliveryPhotos.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedPhotoIndex == index;
                    
                    return GestureDetector(
                      onTap: () {
                        selectedPhotoIndex = index;
                        setState(() {});
                      },
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            deliveryPhotos[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            SizedBox(height: spLg),

            // Delivery Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  _buildDetailRow(
                    Icons.person,
                    "Delivered by",
                    "${deliveryInfo["deliveryPerson"]}",
                  ),
                  _buildDetailRow(
                    Icons.phone,
                    "Contact",
                    "${deliveryInfo["deliveryPersonPhone"]}",
                  ),
                  _buildDetailRow(
                    Icons.location_on,
                    "Address",
                    "${deliveryInfo["deliveryAddress"]}",
                  ),
                  _buildDetailRow(
                    Icons.access_time,
                    "Delivered at",
                    "${deliveryInfo["actualDeliveryTime"]}",
                  ),
                  _buildDetailRow(
                    Icons.note,
                    "Instructions",
                    "${deliveryInfo["deliveryInstructions"]}",
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Delivery Feedback
            Text(
              "Leave Feedback",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Rating
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate your delivery experience",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          deliveryInfo["customerRating"] = index + 1;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.star,
                          color: index < (deliveryInfo["customerRating"] as int)
                              ? warningColor
                              : disabledColor,
                          size: 32,
                        ),
                      );
                    }),
                  ),
                  
                  if ((deliveryInfo["customerRating"] as int) > 0) ...[
                    SizedBox(height: spSm),
                    Text(
                      _getRatingText(deliveryInfo["customerRating"] as int),
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Feedback Note
            QMemoField(
              label: "Additional feedback",
              value: deliveryNote,
              hint: "Share your delivery experience...",
              onChanged: (value) {
                deliveryNote = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Contact Delivery Person",
                    size: bs.md,
                    onPressed: () {
                      _contactDeliveryPerson();
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Submit Feedback",
                    size: bs.md,
                    onPressed: () {
                      _submitFeedback();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Report Issue
            Container(
              width: double.infinity,
              child: QButton(
                label: "Report Delivery Issue",
                size: bs.sm,
                onPressed: () {
                  _reportIssue();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 18,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Poor - We'll work to improve";
      case 2:
        return "Fair - Could be better";
      case 3:
        return "Good - Satisfactory service";
      case 4:
        return "Very Good - Great experience";
      case 5:
        return "Excellent - Outstanding service!";
      default:
        return "";
    }
  }

  void _shareDeliveryPhotos() {
    ss("Delivery photos shared successfully!");
  }

  void _downloadPhotos() {
    ss("Photos downloaded to your device!");
  }

  void _contactDeliveryPerson() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact Delivery Person"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${deliveryInfo["deliveryPerson"]}"),
            Text("${deliveryInfo["deliveryPersonPhone"]}"),
          ],
        ),
        actions: [
          QButton(
            label: "Call",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Calling delivery person...");
            },
          ),
          QButton(
            label: "Message",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Opening message...");
            },
          ),
        ],
      ),
    );
  }

  void _submitFeedback() {
    if ((deliveryInfo["customerRating"] as int) == 0) {
      sw("Please rate your delivery experience");
      return;
    }
    
    ss("Thank you for your feedback!");
  }

  void _reportIssue() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Report Delivery Issue"),
        content: Text("What type of issue would you like to report?"),
        actions: [
          QButton(
            label: "Wrong Address",
            size: bs.sm,
            onPressed: () {
              back();
              se("Issue reported: Wrong delivery address");
            },
          ),
          QButton(
            label: "Missing Items",
            size: bs.sm,
            onPressed: () {
              back();
              se("Issue reported: Missing items");
            },
          ),
          QButton(
            label: "Other",
            size: bs.sm,
            onPressed: () {
              back();
              se("Issue reported: Other");
            },
          ),
        ],
      ),
    );
  }
}
