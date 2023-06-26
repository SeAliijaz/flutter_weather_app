// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_weather_app/Constants/constants.dart';
// import 'package:flutter_weather_app/Custom_Widgets/appbar_gradient.dart';
// import 'package:flutter_weather_app/Custom_Widgets/custom_shimmer_effect.dart';
// import 'package:flutter_weather_app/Models/weather_data_model.dart';
// import 'package:http/http.dart' as http;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   ///Variables
//   final TextEditingController _searchController = TextEditingController();

//   ///final
//   WeatherDataModel? _weatherData;

//   Future<void> fetchData(String location) async {
//     final String apiUrl =
//         'http://api.weatherapi.com/v1/current.json?key=${ApiConstants.apiKey}&q=$location&aqi=no';
//     var response = await http.get(Uri.parse(apiUrl));

//     ///try n catch
//     try {
//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body.toString());
//         debugPrint(response.body.toString());
//         setState(() {
//           _weatherData = WeatherDataModel.fromJson(jsonData);
//         });
//       } else {
//         throw Exception('Failed to load weather data');
//       }
//     } catch (e) {
//       AppConstants.showToast(e.toString());
//       throw Exception();
//     }
//   }

//   ///Disposing Textfield
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       ///AppBar
//       appBar: AppBar(
//         title: Text('Weather App'),
//         centerTitle: true,

//         ///AppBar Gradient
//         flexibleSpace: AppBarGradient(),

//         ///Leading Icon
//         leading: Icon(Icons.menu_outlined),

//         ///Search Field Here
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(70.0),
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search_outlined),
//                 hintText: 'Search location',
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.send_outlined),

//                   ///Search Bar On Pressed
//                   onPressed: () {
//                     String location = _searchController.text;
//                     fetchData(location);
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),

//       ///Body
//       body: FutureBuilder<WeatherDataModel>(
//         future: fetchData(location),
//         // initialData: InitialData,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           return ;
//         },
//       ),
//     );
//   }
// }

/*
  ListView(
               children: [
                 ListTile(
                   leading: Icon(Icons.location_on),
                   title: Text('Location: ${_weatherData!.location!.name}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.location_city),
                   title: Text('Region: ${_weatherData!.location!.region}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.public),
                   title: Text('Country: ${_weatherData!.location!.country}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.location_on),
                   title: Text('Latitude: ${_weatherData!.location!.lat}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.location_on),
                   title: Text('Longitude: ${_weatherData!.location!.lon}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.access_time),
                   title:
                       Text('Local Time: ${_weatherData!.location!.localtime}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.thermostat_outlined),
                   title: Text(
                       'Temperature (Celsius): ${_weatherData!.current!.tempC}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.thermostat_outlined),
                   title: Text(
                       'Temperature (Fahrenheit): ${_weatherData!.current!.tempF}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.wb_sunny),
                   title: Text('Is Day: ${_weatherData!.current!.isDay}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.waves),
                   title: Text(
                       'Wind Speed (MPH): ${_weatherData!.current!.windMph}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.waves),
                   title: Text(
                       'Wind Speed (KPH): ${_weatherData!.current!.windKph}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.navigation),
                   title:
                       Text('Wind Direction: ${_weatherData!.current!.windDir}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.barcode_reader),
                   title: Text(
                       'Pressure (mb): ${_weatherData!.current!.pressureMb}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.barcode_reader),
                   title: Text(
                       'Pressure (in): ${_weatherData!.current!.pressureIn}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.umbrella),
                   title: Text(
                       'Precipitation (mm): ${_weatherData!.current!.precipMm}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.umbrella),
                   title: Text(
                       'Precipitation (in): ${_weatherData!.current!.precipIn}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.opacity),
                   title: Text('Humidity: ${_weatherData!.current!.humidity}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.cloud),
                   title: Text('Cloud: ${_weatherData!.current!.cloud}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.thermostat_outlined),
                   title: Text(
                       'Feels Like (Celsius): ${_weatherData!.current!.feelslikeC}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.thermostat_outlined),
                   title: Text(
                       'Feels Like (Fahrenheit): ${_weatherData!.current!.feelslikeF}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.visibility),
                   title:
                       Text('Visibility (km): ${_weatherData!.current!.visKm}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.visibility),
                   title: Text(
                       'Visibility (miles): ${_weatherData!.current!.visMiles}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.wb_sunny),
                   title: Text('UV Index: ${_weatherData!.current!.uv}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.waves),
                   title: Text(
                       'Gust Speed (MPH): ${_weatherData!.current!.gustMph}'),
                 ),
                 ListTile(
                   leading: Icon(Icons.waves),
                   title: Text(
                       'Gust Speed (KPH): ${_weatherData!.current!.gustKph}'),
                 ),
               ],
             )
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Constants/constants.dart';
import 'package:flutter_weather_app/Custom_Widgets/appbar_gradient.dart';
import 'package:flutter_weather_app/Models/weather_data_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<WeatherDataModel>? _weatherDataFuture;

  Future<WeatherDataModel> fetchData(String location) async {
    final String apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=${ApiConstants.apiKey}&q=$location&aqi=no';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body.toString());
      debugPrint(response.body.toString());
      return WeatherDataModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        flexibleSpace: AppBarGradient(),
        leading: Icon(Icons.menu_outlined),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_outlined),
                hintText: 'Search location',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send_outlined),
                  onPressed: () {
                    String location = _searchController.text;
                    setState(() {
                      _weatherDataFuture = fetchData(location);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: _weatherDataFuture != null
          ? FutureBuilder<WeatherDataModel>(
              future: _weatherDataFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<WeatherDataModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load weather data'),
                  );
                } else {
                  ///value assigned to snapshot.data
                  WeatherDataModel? weatherData = snapshot.data;
                  if (weatherData != null) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(
                                  'Location: ${weatherData.location!.name}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_city),
                              title: Text(
                                  'Region: ${weatherData.location!.region}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.public),
                              title: Text(
                                  'Country: ${weatherData.location!.country}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(
                                  'Latitude: ${weatherData.location!.lat}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(
                                  'Longitude: ${weatherData.location!.lon}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.access_time),
                              title: Text(
                                  'Local Time: ${weatherData.location!.localtime}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Temperature (Celsius): ${weatherData.current!.tempC}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Temperature (Fahrenheit): ${weatherData.current!.tempF}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.wb_sunny),
                              title:
                                  Text('Is Day: ${weatherData.current!.isDay}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.waves),
                              title: Text(
                                  'Wind Speed (MPH): ${weatherData.current!.windMph}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.waves),
                              title: Text(
                                  'Wind Speed (KPH): ${weatherData.current!.windKph}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.navigation),
                              title: Text(
                                  'Wind Direction: ${weatherData.current!.windDir}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.barcode_reader),
                              title: Text(
                                  'Pressure (mb): ${weatherData.current!.pressureMb}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.barcode_reader),
                              title: Text(
                                  'Pressure (in): ${weatherData.current!.pressureIn}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.umbrella),
                              title: Text(
                                  'Precipitation (mm): ${weatherData.current!.precipMm}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.umbrella),
                              title: Text(
                                  'Precipitation (in): ${weatherData.current!.precipIn}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.opacity),
                              title: Text(
                                  'Humidity: ${weatherData.current!.humidity}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.cloud),
                              title:
                                  Text('Cloud: ${weatherData.current!.cloud}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Feels Like (Celsius): ${weatherData.current!.feelslikeC}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.thermostat_outlined),
                              title: Text(
                                  'Feels Like (Fahrenheit): ${weatherData.current!.feelslikeF}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.visibility),
                              title: Text(
                                  'Visibility (km): ${weatherData.current!.visKm}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.visibility),
                              title: Text(
                                  'Visibility (miles): ${weatherData.current!.visMiles}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.wb_sunny),
                              title:
                                  Text('UV Index: ${weatherData.current!.uv}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.waves),
                              title: Text(
                                  'Gust Speed (MPH): ${weatherData.current!.gustMph}'),
                            ),
                            ListTile(
                              leading: Icon(Icons.waves),
                              title: Text(
                                  'Gust Speed (KPH): ${weatherData.current!.gustKph}'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No weather data available'),
                    );
                  }
                }
              },
            )
          : Container(),
    );
  }
}
