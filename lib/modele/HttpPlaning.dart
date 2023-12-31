import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voyageur_app/modele/planningmainModel.dart';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HTTPHandlerplaning {
  final storage = const FlutterSecureStorage();

  // String baseurl = "https://jsonplaceholder.typicode.com/photos";
  String baseurl = "https://api.zenify-trip.continuousnet.com/api/plannings";
  String token = "";
  Future<List<PlanningMainModel>> fetchData(String url) async {
    // token = await storage.read(key: "access_token");
    String? token = await storage.read(key: "access_token");
    List<PlanningMainModel> planingList = [];
    url = formater(url);
    final respond =
        await http.get(headers: {"Authorization": "$token"}, Uri.parse(url));
    print(respond.statusCode);
    if (respond.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // var data = jsonDecode(respond.body);
      // print(data);
      // final touristGuideName = data["results"]["agency"];
      // print(touristGuideName);
      final data = json.decode(respond.body);

      final List r = data["results"];
      // var r = json.decode(res.body);
      // final data = r["results"];
      print("----------------------------------------------");
      print(r[0]["startDate"]);
      print("----------------------------------------------");

      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      // return result;
      return r.map((e) => PlanningMainModel.fromJson(e)).toList();
// r.map((e) => PlanningMainModel.fromJson({"results": e})).toList();
      // return activityList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${respond.statusCode}');
    }
  }

  Future<DateTime> fetchtime(String url) async {
    List<PlanningMainModel> planingList = [];
    url = formater(url);
    String? token = await storage.read(key: "access_token");
    final respond =
        await http.get(headers: {"Authorization": "$token"}, Uri.parse(url));
    print(respond.statusCode);
    if (respond.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // var data = jsonDecode(respond.body);
      // print(data);
      // final touristGuideName = data["results"]["agency"];
      // print(touristGuideName);
      final data = json.decode(respond.body);

      final List r = data["results"];
      // var r = json.decode(res.body);
      // final data = r["results"];
      print("----------------------------------------------");
      print(r[0]["startDate"]);
      print("----------------------------------------------");

      // for (Map<String, dynamic> d in data) {
      //   Activity activity = Activity.fromJSON(d);
      //   activityList.add(activity);
      // }
      // return result;
      return r[0]["startDate"];
// r.map((e) => PlanningMainModel.fromJson({"results": e})).toList();
      // return activityList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('${respond.statusCode}');
    }
  }

  String formater(String url) {
    return baseurl + url;
  }
}
