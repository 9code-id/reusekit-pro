import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaTravelWeatherView extends StatefulWidget {
  const WcaTravelWeatherView({super.key});

  @override
  State<WcaTravelWeatherView> createState() => _WcaTravelWeatherViewState();
}

class _WcaTravelWeatherViewState extends State<WcaTravelWeatherView> {
  String departureCity = "New York";
  String destinationCity = "Paris";
  String travelDate = DateTime.now().add(Duration(days: 7)).toString().split(' ')[0];
  String returnDate = DateTime.now().add(Duration(days: 14)).toString().split(' ')[0];

  List<Map<String, dynamic>> popularDestinations = [
    {
      "city": "Paris",
      "country": "France",
      "temperature": 68,
      "condition": "Partly Cloudy",
      "humidity": 65,
      "precipitation": 20,
      "season": "Spring",
      "bestTime": "Apr-Jun, Sep-Oct",
      "image": "https://picsum.photos/300/200?random=1&keyword=paris",
      "icon": Icons.wb_cloudy,
    },
    {
      "city": "Tokyo",
      "country": "Japan",
      "temperature": 72,
      "condition": "Sunny",
      "humidity": 55,
      "precipitation": 10,
      "season": "Spring",
      "bestTime": "Mar-May, Sep-Nov",
      "image": "https://picsum.photos/300/200?random=2&keyword=tokyo",
      "icon": Icons.wb_sunny,
    },
    {
      "city": "London",
      "country": "UK",
      "temperature": 63,
      "condition": "Light Rain",
      "humidity": 75,
      "precipitation": 60,
      "season": "Spring",
      "bestTime": "May-Sep",
      "image": "https://picsum.photos/300/200?random=3&keyword=london",
      "icon": Icons.grain,
    },
  ];

  List<Map<String, dynamic>> travelForecast = [
    {
      "date": "Departure Day",
      "location": "New York",
      "temperature": 75,
      "condition": "Sunny",
      "humidity": 45,
      "precipitation": 0,
      "advice": "Perfect weather for departure",
      "color": "success",
      "icon": Icons.wb_sunny,
    },
    {
      "date": "Days 1-3",
      "location": "Paris",
      "temperature": 68,
      "condition": "Partly Cloudy",
      "humidity": 65,
      "precipitation": 20,
      "advice": "Pack light jacket for evenings",
      "color": "info",
      "icon": Icons.wb_cloudy,
    },
    {
      "date": "Days 4-7",
      "location": "Paris",
      "temperature": 71,
      "condition": "Sunny",
      "humidity": 55,
      "precipitation": 5,
      "advice": "Great weather for sightseeing",
      "color": "success",
      "icon": Icons.wb_sunny,
    },
    {
      "date": "Return Day",
      "location": "New York",
      "temperature": 78,
      "condition": "Clear",
      "humidity": 50,
      "precipitation": 0,
      "advice": "Clear skies for return flight",
      "color": "success",
      "icon": Icons.wb_sunny,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              si("Save travel weather plan");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Share travel weather forecast");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), infoColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.travel_explore,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Travel Weather Planning",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Plan your perfect trip with weather insights",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Trip Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "From",
                    value: departureCity,
                    hint: "Departure city",
                    onChanged: (value) {
                      departureCity = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "To",
                    value: destinationCity,
                    hint: "Destination city",
                    onChanged: (value) {
                      destinationCity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Departure Date",
                    value: DateTime.parse(travelDate),
                    onChanged: (value) {
                      travelDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDatePicker(
                    label: "Return Date",
                    value: DateTime.parse(returnDate),
                    onChanged: (value) {
                      returnDate = value.toString().split(' ')[0];
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Trip Weather Forecast",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...travelForecast.map((forecast) {
              Color statusColor = primaryColor;
              if (forecast["color"] == "success") statusColor = successColor;
              if (forecast["color"] == "warning") statusColor = warningColor;
              if (forecast["color"] == "info") statusColor = infoColor;

              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      forecast["icon"] as IconData,
                      color: statusColor,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${forecast["date"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                              Text(
                                "${forecast["location"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${forecast["temperature"]}°F - ${forecast["condition"]}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${forecast["advice"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            Text(
              "Popular Destinations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: popularDestinations.map((destination) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                        child: Image.network(
                          "${destination["image"]}",
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${destination["city"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${destination["country"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      destination["icon"] as IconData,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${destination["temperature"]}°F",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${destination["condition"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildWeatherStat("Humidity", "${destination["humidity"]}%"),
                                ),
                                Expanded(
                                  child: _buildWeatherStat("Rain", "${destination["precipitation"]}%"),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Best Time: ${destination["bestTime"]}",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Season: ${destination["season"]}",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Travel Weather Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Check weather 24-48 hours before departure",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Pack layers for changing weather conditions",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Monitor flight delays due to weather",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Download offline weather apps for backup",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Get Detailed Travel Forecast",
              size: bs.md,
              onPressed: () {
                si("Loading detailed travel weather forecast");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
