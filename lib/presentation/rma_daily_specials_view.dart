import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaDailySpecialsView extends StatefulWidget {
  const RmaDailySpecialsView({super.key});

  @override
  State<RmaDailySpecialsView> createState() => _RmaDailySpecialsViewState();
}

class _RmaDailySpecialsViewState extends State<RmaDailySpecialsView> {
  DateTime selectedDate = DateTime.now();
  String selectedDay = DateTime.now().weekday == 1 ? "monday" : 
                      DateTime.now().weekday == 2 ? "tuesday" :
                      DateTime.now().weekday == 3 ? "wednesday" :
                      DateTime.now().weekday == 4 ? "thursday" :
                      DateTime.now().weekday == 5 ? "friday" :
                      DateTime.now().weekday == 6 ? "saturday" : "sunday";
  
  Map<String, List<Map<String, dynamic>>> weeklySpecials = {
    "monday": [
      {
        "id": "monday_1",
        "name": "Meatball Monday",
        "description": "Classic spaghetti and meatballs with marinara sauce",
        "originalPrice": 16.99,
        "specialPrice": 12.99,
        "discount": 23.5,
        "category": "pasta",
        "cookTime": 15,
        "ingredients": ["spaghetti", "meatballs", "marinara", "parmesan"],
        "allergens": ["gluten", "dairy"],
        "image": "https://picsum.photos/300/200?random=1&keyword=spaghetti",
        "available": true,
        "stockCount": 25
      },
      {
        "id": "monday_2", 
        "name": "Monday Wings",
        "description": "1 dozen buffalo wings with celery and blue cheese",
        "originalPrice": 14.99,
        "specialPrice": 9.99,
        "discount": 33.4,
        "category": "appetizers",
        "cookTime": 12,
        "ingredients": ["chicken wings", "buffalo sauce", "celery", "blue cheese"],
        "allergens": ["dairy"],
        "image": "https://picsum.photos/300/200?random=2&keyword=wings",
        "available": true,
        "stockCount": 18
      }
    ],
    "tuesday": [
      {
        "id": "tuesday_1",
        "name": "Taco Tuesday",
        "description": "3 street tacos with choice of meat and fresh toppings",
        "originalPrice": 13.99,
        "specialPrice": 8.99,
        "discount": 35.7,
        "category": "mexican",
        "cookTime": 10,
        "ingredients": ["corn tortillas", "choice of meat", "onions", "cilantro", "lime"],
        "allergens": [],
        "image": "https://picsum.photos/300/200?random=3&keyword=tacos",
        "available": true,
        "stockCount": 30
      },
      {
        "id": "tuesday_2",
        "name": "Tuesday Margaritas",
        "description": "House margarita with premium tequila",
        "originalPrice": 12.00,
        "specialPrice": 6.00,
        "discount": 50.0,
        "category": "beverages",
        "cookTime": 3,
        "ingredients": ["tequila", "lime juice", "triple sec", "salt rim"],
        "allergens": [],
        "image": "https://picsum.photos/300/200?random=4&keyword=margarita",
        "available": true,
        "stockCount": 50
      }
    ],
    "wednesday": [
      {
        "id": "wednesday_1",
        "name": "Wine Wednesday",
        "description": "Select wines by the glass at special prices",
        "originalPrice": 9.00,
        "specialPrice": 5.00,
        "discount": 44.4,
        "category": "beverages",
        "cookTime": 1,
        "ingredients": ["premium wine selection"],
        "allergens": ["sulfites"],
        "image": "https://picsum.photos/300/200?random=5&keyword=wine",
        "available": true,
        "stockCount": 40
      },
      {
        "id": "wednesday_2",
        "name": "Pasta Special",
        "description": "Chef's choice pasta with seasonal vegetables",
        "originalPrice": 18.99,
        "specialPrice": 13.99,
        "discount": 26.3,
        "category": "pasta",
        "cookTime": 18,
        "ingredients": ["fresh pasta", "seasonal vegetables", "olive oil", "herbs"],
        "allergens": ["gluten"],
        "image": "https://picsum.photos/300/200?random=6&keyword=pasta",
        "available": true,
        "stockCount": 20
      }
    ],
    "thursday": [
      {
        "id": "thursday_1",
        "name": "Throwback Thursday",
        "description": "Classic burger with fries and a shake",
        "originalPrice": 17.99,
        "specialPrice": 12.99,
        "discount": 27.8,
        "category": "burgers",
        "cookTime": 15,
        "ingredients": ["beef patty", "lettuce", "tomato", "cheese", "fries", "milkshake"],
        "allergens": ["gluten", "dairy"],
        "image": "https://picsum.photos/300/200?random=7&keyword=burger",
        "available": true,
        "stockCount": 22
      }
    ],
    "friday": [
      {
        "id": "friday_1",
        "name": "Fish Friday",
        "description": "Beer battered fish and chips with tartar sauce",
        "originalPrice": 19.99,
        "specialPrice": 15.99,
        "discount": 20.0,
        "category": "seafood",
        "cookTime": 18,
        "ingredients": ["fresh fish", "beer batter", "fries", "tartar sauce", "lemon"],
        "allergens": ["gluten", "fish"],
        "image": "https://picsum.photos/300/200?random=8&keyword=fish",
        "available": true,
        "stockCount": 15
      },
      {
        "id": "friday_2",
        "name": "Friday Night Pizza",
        "description": "Large specialty pizza with premium toppings",
        "originalPrice": 24.99,
        "specialPrice": 19.99,
        "discount": 20.0,
        "category": "pizza",
        "cookTime": 20,
        "ingredients": ["pizza dough", "premium toppings", "mozzarella", "sauce"],
        "allergens": ["gluten", "dairy"],
        "image": "https://picsum.photos/300/200?random=9&keyword=pizza",
        "available": true,
        "stockCount": 12
      }
    ],
    "saturday": [
      {
        "id": "saturday_1",
        "name": "Saturday Brunch",
        "description": "Eggs Benedict with hollandaise and home fries",
        "originalPrice": 16.99,
        "specialPrice": 13.99,
        "discount": 17.7,
        "category": "brunch",
        "cookTime": 12,
        "ingredients": ["english muffin", "poached eggs", "ham", "hollandaise", "potatoes"],
        "allergens": ["gluten", "dairy", "eggs"],
        "image": "https://picsum.photos/300/200?random=10&keyword=brunch",
        "available": true,
        "stockCount": 28
      },
      {
        "id": "saturday_2",
        "name": "Steak Saturday",
        "description": "8oz ribeye with mashed potatoes and vegetables",
        "originalPrice": 32.99,
        "specialPrice": 26.99,
        "discount": 18.2,
        "category": "steaks",
        "cookTime": 25,
        "ingredients": ["ribeye steak", "mashed potatoes", "seasonal vegetables"],
        "allergens": ["dairy"],
        "image": "https://picsum.photos/300/200?random=11&keyword=steak",
        "available": true,
        "stockCount": 8
      }
    ],
    "sunday": [
      {
        "id": "sunday_1",
        "name": "Sunday Roast",
        "description": "Traditional roast chicken with all the fixings",
        "originalPrice": 22.99,
        "specialPrice": 17.99,
        "discount": 21.7,
        "category": "roasts",
        "cookTime": 30,
        "ingredients": ["roast chicken", "vegetables", "gravy", "potatoes"],
        "allergens": ["gluten"],
        "image": "https://picsum.photos/300/200?random=12&keyword=roast",
        "available": true,
        "stockCount": 20
      },
      {
        "id": "sunday_2",
        "name": "Family Pizza Deal",
        "description": "2 large pizzas + appetizer + 2L soda",
        "originalPrice": 45.99,
        "specialPrice": 34.99,
        "discount": 23.9,
        "category": "family",
        "cookTime": 25,
        "ingredients": ["2 pizzas", "appetizer", "soda"],
        "allergens": ["gluten", "dairy"],
        "image": "https://picsum.photos/300/200?random=13&keyword=family",
        "available": true,
        "stockCount": 10
      }
    ]
  };

  List<String> dayNames = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];
  List<String> dayLabels = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  Widget _buildDaySelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Day",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: List.generate(dayNames.length, (index) {
              final day = dayNames[index];
              final isSelected = selectedDay == day;
              final specialsCount = weeklySpecials[day]?.length ?? 0;
              
              return Container(
                width: 100,
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedDay = day;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          dayLabels[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (isSelected ? Colors.white : successColor).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "$specialsCount special${specialsCount != 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? primaryColor : successColor,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildSpecialCard(Map<String, dynamic> special) {
    final savings = (special["originalPrice"] as double) - (special["specialPrice"] as double);
    final stockColor = (special["stockCount"] as int) > 10 ? successColor :
                      (special["stockCount"] as int) > 5 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage("${special["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(80),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "-${(special["discount"] as double).toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: stockColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${special["stockCount"]} left",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Text(
                    "${special["cookTime"]} min",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${special["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${special["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${special["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Text(
                      "\$${((special["originalPrice"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((special["specialPrice"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Save \$${savings.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            (special["ingredients"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          if ((special["allergens"] as List).isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Text(
                              "Allergens: ${(special["allergens"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 10,
                                color: dangerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add to Order",
                        icon: Icons.add_shopping_cart,
                        size: bs.sm,
                        onPressed: special["available"] as bool ? () {
                          //navigateTo('RmaAddToOrderView')
                        } : null,
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('RmaEditSpecialView')
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.visibility,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('RmaSpecialDetailView')
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
  }

  List<Map<String, dynamic>> get todaysSpecials {
    return weeklySpecials[selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Specials"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('RmaAddDailySpecialView')
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              //navigateTo('RmaSpecialsCalendarView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDaySelector(),
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
                      Text(
                        "${dayLabels[dayNames.indexOf(selectedDay)]} Specials",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${todaysSpecials.length} specials available",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (todaysSpecials.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No specials for this day",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Add a special to boost sales on this day",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: todaysSpecials.map((special) => _buildSpecialCard(special)).toList(),
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
