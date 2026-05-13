import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPostServiceCareView extends StatefulWidget {
  const BrsPostServiceCareView({super.key});

  @override
  State<BrsPostServiceCareView> createState() => _BrsPostServiceCareViewState();
}

class _BrsPostServiceCareViewState extends State<BrsPostServiceCareView> {
  Map<String, dynamic> serviceInfo = {
    "service_type": "Premium Haircut + Beard Trim",
    "completion_date": "2024-03-15",
    "barber_name": "John Smith",
    "hair_type": "Thick, Wavy",
    "beard_type": "Medium Length",
  };

  List<Map<String, dynamic>> careInstructions = [
    {
      "title": "First 24 Hours",
      "icon": Icons.schedule,
      "items": [
        "Avoid washing your hair for at least 24 hours",
        "Don't touch or style your hair excessively",
        "Avoid using any heat styling tools",
        "Keep your hair dry during this period",
      ],
    },
    {
      "title": "Hair Care Routine",
      "icon": Icons.local_florist,
      "items": [
        "Use sulfate-free shampoo when you first wash",
        "Apply conditioner only to mid-lengths and ends",
        "Use a wide-tooth comb on wet hair to prevent breakage",
        "Let hair air dry whenever possible",
      ],
    },
    {
      "title": "Beard Maintenance",
      "icon": Icons.face,
      "items": [
        "Apply beard oil daily to keep it moisturized",
        "Comb your beard in the direction of growth",
        "Trim stray hairs with small scissors as needed",
        "Wash beard 2-3 times per week with beard shampoo",
      ],
    },
    {
      "title": "Styling Tips",
      "icon": Icons.style,
      "items": [
        "Use a small amount of styling product for best results",
        "Work product through damp hair for even distribution",
        "Use your fingers to create natural texture",
        "Avoid over-brushing to maintain the cut's shape",
      ],
    },
  ];

  List<Map<String, dynamic>> recommendedProducts = [
    {
      "name": "Premium Hair Shampoo",
      "type": "Sulfate-free",
      "price": 24.99,
      "rating": 4.8,
      "image": "https://picsum.photos/80/80?random=20&keyword=shampoo",
    },
    {
      "name": "Nourishing Conditioner",
      "type": "For all hair types",
      "price": 22.99,
      "rating": 4.7,
      "image": "https://picsum.photos/80/80?random=21&keyword=conditioner",
    },
    {
      "name": "Beard Oil",
      "type": "Natural ingredients",
      "price": 18.99,
      "rating": 4.9,
      "image": "https://picsum.photos/80/80?random=22&keyword=oil",
    },
    {
      "name": "Styling Pomade",
      "type": "Medium hold",
      "price": 16.99,
      "rating": 4.6,
      "image": "https://picsum.photos/80/80?random=23&keyword=pomade",
    },
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "task": "Wash hair",
      "frequency": "Every 2-3 days",
      "next_date": "2024-03-17",
    },
    {
      "task": "Apply beard oil",
      "frequency": "Daily",
      "next_date": "2024-03-16",
    },
    {
      "task": "Trim beard edges",
      "frequency": "Weekly",
      "next_date": "2024-03-22",
    },
    {
      "task": "Next haircut",
      "frequency": "4-6 weeks",
      "next_date": "2024-04-19",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post-Service Care"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Recent Service",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.content_cut,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${serviceInfo["service_type"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Completed on ${serviceInfo["completion_date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "By ${serviceInfo["barber_name"]}",
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
                ],
              ),
            ),

            // Care Instructions
            ...careInstructions.map((section) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          section["icon"] as IconData,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${section["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ...(section["items"] as List<String>).map((item) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(top: 6, right: spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),

            // Maintenance Schedule
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Maintenance Schedule",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...maintenanceSchedule.map((schedule) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: primaryColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${schedule["task"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${schedule["frequency"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Next:",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${schedule["next_date"]}",
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
                    );
                  }).toList(),
                ],
              ),
            ),

            // Recommended Products
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommended Products",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...recommendedProducts.map((product) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${product["image"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${product["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: warningColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs/2),
                                    Text(
                                      "${product["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(product["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              QButton(
                                label: "Add to Cart",
                                size: bs.sm,
                                onPressed: () {
                                  ss("${product["name"]} added to cart");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Set Reminders",
                          size: bs.sm,
                          onPressed: () {
                            si("Maintenance reminders set");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Book Next Appointment",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to booking
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Additional Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Pro Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Take photos of your new style for reference",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "• Book your next appointment 4-6 weeks in advance",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "• Contact your barber if you have any concerns",
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
      ),
    );
  }
}
