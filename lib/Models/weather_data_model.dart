class WeatherDataModel {
  Location? location;
  Current? current;

  WeatherDataModel({this.location, this.current});

  WeatherDataModel.fromJson(Map<String, dynamic> json) {
    if (json["location"] is Map) {
      location =
          json["location"] == null ? null : Location.fromJson(json["location"]);
    }
    if (json["current"] is Map) {
      current =
          json["current"] == null ? null : Current.fromJson(json["current"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (location != null) {
      _data["location"] = location?.toJson();
    }
    if (current != null) {
      _data["current"] = current?.toJson();
    }
    return _data;
  }
}

class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  int? tempC;
  int? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;
  int? pressureMb;
  double? pressureIn;
  int? precipMm;
  int? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  int? visKm;
  int? visMiles;
  int? uv;
  double? gustMph;
  double? gustKph;

  Current(
      {this.lastUpdatedEpoch,
      this.lastUpdated,
      this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windMph,
      this.windKph,
      this.windDegree,
      this.windDir,
      this.pressureMb,
      this.pressureIn,
      this.precipMm,
      this.precipIn,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.feelslikeF,
      this.visKm,
      this.visMiles,
      this.uv,
      this.gustMph,
      this.gustKph});

  Current.fromJson(Map<String, dynamic> json) {
    if (json["last_updated_epoch"] is int) {
      lastUpdatedEpoch = json["last_updated_epoch"];
    }
    if (json["last_updated"] is String) {
      lastUpdated = json["last_updated"];
    }
    if (json["temp_c"] is int) {
      tempC = json["temp_c"];
    }
    if (json["temp_f"] is int) {
      tempF = json["temp_f"];
    }
    if (json["is_day"] is int) {
      isDay = json["is_day"];
    }
    if (json["condition"] is Map) {
      condition = json["condition"] == null
          ? null
          : Condition.fromJson(json["condition"]);
    }
    if (json["wind_mph"] is double) {
      windMph = json["wind_mph"];
    }
    if (json["wind_kph"] is double) {
      windKph = json["wind_kph"];
    }
    if (json["wind_degree"] is int) {
      windDegree = json["wind_degree"];
    }
    if (json["wind_dir"] is String) {
      windDir = json["wind_dir"];
    }
    if (json["pressure_mb"] is int) {
      pressureMb = json["pressure_mb"];
    }
    if (json["pressure_in"] is double) {
      pressureIn = json["pressure_in"];
    }
    if (json["precip_mm"] is int) {
      precipMm = json["precip_mm"];
    }
    if (json["precip_in"] is int) {
      precipIn = json["precip_in"];
    }
    if (json["humidity"] is int) {
      humidity = json["humidity"];
    }
    if (json["cloud"] is int) {
      cloud = json["cloud"];
    }
    if (json["feelslike_c"] is double) {
      feelslikeC = json["feelslike_c"];
    }
    if (json["feelslike_f"] is double) {
      feelslikeF = json["feelslike_f"];
    }
    if (json["vis_km"] is int) {
      visKm = json["vis_km"];
    }
    if (json["vis_miles"] is int) {
      visMiles = json["vis_miles"];
    }
    if (json["uv"] is int) {
      uv = json["uv"];
    }
    if (json["gust_mph"] is double) {
      gustMph = json["gust_mph"];
    }
    if (json["gust_kph"] is double) {
      gustKph = json["gust_kph"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["last_updated_epoch"] = lastUpdatedEpoch;
    _data["last_updated"] = lastUpdated;
    _data["temp_c"] = tempC;
    _data["temp_f"] = tempF;
    _data["is_day"] = isDay;
    if (condition != null) {
      _data["condition"] = condition?.toJson();
    }
    _data["wind_mph"] = windMph;
    _data["wind_kph"] = windKph;
    _data["wind_degree"] = windDegree;
    _data["wind_dir"] = windDir;
    _data["pressure_mb"] = pressureMb;
    _data["pressure_in"] = pressureIn;
    _data["precip_mm"] = precipMm;
    _data["precip_in"] = precipIn;
    _data["humidity"] = humidity;
    _data["cloud"] = cloud;
    _data["feelslike_c"] = feelslikeC;
    _data["feelslike_f"] = feelslikeF;
    _data["vis_km"] = visKm;
    _data["vis_miles"] = visMiles;
    _data["uv"] = uv;
    _data["gust_mph"] = gustMph;
    _data["gust_kph"] = gustKph;
    return _data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    if (json["text"] is String) {
      text = json["text"];
    }
    if (json["icon"] is String) {
      icon = json["icon"];
    }
    if (json["code"] is int) {
      code = json["code"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["text"] = text;
    _data["icon"] = icon;
    _data["code"] = code;
    return _data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  Location(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tzId,
      this.localtimeEpoch,
      this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["region"] is String) {
      region = json["region"];
    }
    if (json["country"] is String) {
      country = json["country"];
    }
    if (json["lat"] is double) {
      lat = json["lat"];
    }
    if (json["lon"] is double) {
      lon = json["lon"];
    }
    if (json["tz_id"] is String) {
      tzId = json["tz_id"];
    }
    if (json["localtime_epoch"] is int) {
      localtimeEpoch = json["localtime_epoch"];
    }
    if (json["localtime"] is String) {
      localtime = json["localtime"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["region"] = region;
    _data["country"] = country;
    _data["lat"] = lat;
    _data["lon"] = lon;
    _data["tz_id"] = tzId;
    _data["localtime_epoch"] = localtimeEpoch;
    _data["localtime"] = localtime;
    return _data;
  }
}
