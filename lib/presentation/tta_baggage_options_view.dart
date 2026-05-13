import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaBaggageOptionsView extends StatefulWidget {
  const TtaBaggageOptionsView({super.key});

  @override
  State<TtaBaggageOptionsView> createState() => _TtaBaggageOptionsViewState();
}

class _TtaBaggageOptionsViewState extends State<TtaBaggageOptionsView> {
  String selectedCabinBag = "included";
  String selectedCheckedBag = "none";
  String selectedExcessWeight = "none";
  String selectedSpecialItems = "";
  bool priorityBoarding = false;
  bool fastTrackSecurity = false;

  final List<Map<String, dynamic>> cabinBagOptions = [
    {
      "id": "included",
      "title": "Cabin Bag Included",
      "description": "1 cabin bag up to 7kg (55x40x20cm)",
      "price": 0,
      "included": true,
    },
    {
      "id": "extra_small",
      "title": "Extra Small Cabin Bag",
      "description": "Additional small bag (40x30x15cm)",
      "price": 15,
      "included": false,
    },
    {
      "id": "premium_cabin",
      "title": "Premium Cabin Bag",
      "description": "Priority cabin bag up to 10kg",
      "price": 25,
      "included": false,
    },
  ];

  final List<Map<String, dynamic>> checkedBagOptions = [
    {
      "id": "none",
      "title": "No Checked Bag",
      "description": "Travel with cabin bag only",
      "price": 0,
      "weight": "0kg",
    },
    {
      "id": "standard_20",
      "title": "Standard Checked Bag",
      "description": "Up to 20kg checked baggage",
      "price": 45,
      "weight": "20kg",
    },
    {
      "id": "standard_23",
      "title": "Standard Plus",
      "description": "Up to 23kg checked baggage",
      "price": 55,
      "weight": "23kg",
    },
    {
      "id": "heavy_30",
      "title": "Heavy Bag",
      "description": "Up to 30kg checked baggage",
      "price": 85,
      "weight": "30kg",
    },
    {
      "id": "extra_heavy_32",
      "title": "Extra Heavy Bag",
      "description": "Up to 32kg checked baggage",
      "price": 95,
      "weight": "32kg",
    },
  ];

  final List<Map<String, dynamic>> excessWeightOptions = [
    {
      "id": "none",
      "title": "No Additional Weight",
      "description": "Standard weight allowance",
      "price": 0,
    },
    {
      "id": "extra_3kg",
      "title": "+3kg Extra Weight",
      "description": "Additional 3kg weight allowance",
      "price": 25,
    },
    {
      "id": "extra_5kg",
      "title": "+5kg Extra Weight",
      "description": "Additional 5kg weight allowance",
      "price": 40,
    },
    {
      "id": "extra_10kg",
      "title": "+10kg Extra Weight",
      "description": "Additional 10kg weight allowance",
      "price": 75,
    },
  ];

  final List<Map<String, dynamic>> specialItems = [
    {
      "id": "sports_equipment",
      "title": "Sports Equipment",
      "description": "Golf clubs, skis, surfboards, etc.",
      "price": 65,
      "icon": Icons.sports_tennis,
    },
    {
      "id": "musical_instrument",
      "title": "Musical Instrument",
      "description": "Guitar, violin, small instruments",
      "price": 85,
      "icon": Icons.music_note,
    },
    {
      "id": "bicycle",
      "title": "Bicycle",
      "description": "Standard bicycle in bike box",
      "price": 95,
      "icon": Icons.directions_bike,
    },
    {
      "id": "fragile_items",
      "title": "Fragile Items",
      "description": "Electronics, artwork, antiques",
      "price": 45,
      "icon": Icons.warning,
    },
  ];

  double getTotalPrice() {
    double total = 0;
    
    // Cabin bag price
    final cabinBag = cabinBagOptions.firstWhere((bag) => bag["id"] == selectedCabinBag);
    total += (cabinBag["price"] as int).toDouble();
    
    // Checked bag price
    final checkedBag = checkedBagOptions.firstWhere((bag) => bag["id"] == selectedCheckedBag);
    total += (checkedBag["price"] as int).toDouble();
    
    // Excess weight price
    final excessWeight = excessWeightOptions.firstWhere((option) => option["id"] == selectedExcessWeight);
    total += (excessWeight["price"] as int).toDouble();
    
    // Special items price
    if (selectedSpecialItems.isNotEmpty) {
      final specialItem = specialItems.firstWhere((item) => item["id"] == selectedSpecialItems);
      total += (specialItem["price"] as int).toDouble();
    }
    
    // Additional services
    if (priorityBoarding) total += 15;
    if (fastTrackSecurity) total += 12;
    
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baggage Options"),
        actions: [
          Icon(
            Icons.info_outline,
            color: disabledBoldColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Flight Info Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flight_takeoff,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "JFK → LHR",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Dec 15, 2024 • British Airways BA179",
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

            // Cabin Bag Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Cabin Baggage",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...cabinBagOptions.map((option) {
                    final isSelected = selectedCabinBag == option["id"];
                    final isIncluded = option["included"] as bool;
                    
                    return GestureDetector(
                      onTap: () {
                        selectedCabinBag = option["id"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(20) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected 
                                  ? Icons.radio_button_checked 
                                  : Icons.radio_button_unchecked,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${option["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (isIncluded) ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "INCLUDED",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${option["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              (option["price"] as int) == 0 
                                  ? "FREE" 
                                  : "+\$${(option["price"] as int)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (option["price"] as int) == 0 
                                    ? successColor 
                                    : primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Checked Bag Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Checked Baggage",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...checkedBagOptions.map((option) {
                    final isSelected = selectedCheckedBag == option["id"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedCheckedBag = option["id"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(20) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected 
                                  ? Icons.radio_button_checked 
                                  : Icons.radio_button_unchecked,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${option["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: secondaryColor.withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${option["weight"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${option["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              (option["price"] as int) == 0 
                                  ? "FREE" 
                                  : "\$${(option["price"] as int)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (option["price"] as int) == 0 
                                    ? successColor 
                                    : primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Excess Weight Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Extra Weight",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...excessWeightOptions.map((option) {
                    final isSelected = selectedExcessWeight == option["id"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedExcessWeight = option["id"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(20) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected 
                                  ? Icons.radio_button_checked 
                                  : Icons.radio_button_unchecked,
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${option["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${option["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              (option["price"] as int) == 0 
                                  ? "FREE" 
                                  : "+\$${(option["price"] as int)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (option["price"] as int) == 0 
                                    ? successColor 
                                    : primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Special Items
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Special Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Optional - Select if you're traveling with special items",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  ...specialItems.map((item) {
                    final isSelected = selectedSpecialItems == item["id"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedSpecialItems = isSelected ? "" : item["id"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? warningColor.withAlpha(20) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? warningColor 
                                : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item["icon"] as IconData,
                              color: isSelected ? warningColor : disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${item["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${item["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(item["price"] as int)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Additional Services
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Additional Services",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Priority Boarding (+\$15)",
                              "value": true,
                              "checked": priorityBoarding,
                            }
                          ],
                          value: [
                            if (priorityBoarding)
                              {
                                "label": "Priority Boarding (+\$15)",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            priorityBoarding = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Fast Track Security (+\$12)",
                              "value": true,
                              "checked": fastTrackSecurity,
                            }
                          ],
                          value: [
                            if (fastTrackSecurity)
                              {
                                "label": "Fast Track Security (+\$12)",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            fastTrackSecurity = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Baggage Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Baggage Cost:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        getTotalPrice() == 0 
                            ? "FREE" 
                            : "\$${getTotalPrice().currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: getTotalPrice() == 0 ? successColor : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Continue",
                    size: bs.md,
                    onPressed: () {
                      ss("Baggage options saved! Proceeding to payment...");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.info_outline,
                  size: bs.md,
                  onPressed: () {
                    si("Baggage restrictions and policies");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
