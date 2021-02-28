// To parse this JSON data, do
//
//     final earthQuake = earthQuakeFromJson(jsonString);

import 'dart:convert';

EarthQuake earthQuakeFromJson(String str) => EarthQuake.fromJson(json.decode(str));

String earthQuakeToJson(EarthQuake data) => json.encode(data.toJson());

class EarthQuake {
    EarthQuake({
        this.type,
        this.metadata,
        this.features,
        this.bbox,
    });

    String type;
    Metadata metadata;
    List<Feature> features;
    List<double> bbox;

    factory EarthQuake.fromJson(Map<String, dynamic> json) => EarthQuake(
        type: json["type"],
        metadata: Metadata.fromJson(json["metadata"]),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        bbox: List<double>.from(json["bbox"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "metadata": metadata.toJson(),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
    };
}

class Feature {
    Feature({
        this.type,
        this.properties,
        this.geometry,
        this.id,
    });

    FeatureType type;
    Properties properties;
    Geometry geometry;
    String id;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: featureTypeValues.map[json["type"]],
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "type": featureTypeValues.reverse[type],
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
        "id": id,
    };
}

class Geometry {
    Geometry({
        this.type,
        this.coordinates,
    });

    GeometryType type;
    List<double> coordinates;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: geometryTypeValues.map[json["type"]],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({
    "Point": GeometryType.POINT
});

class Properties {
    Properties({
        this.mag,
        this.place,
        this.time,
        this.updated,
        this.tz,
        this.url,
        this.detail,
        this.felt,
        this.cdi,
        this.mmi,
        this.alert,
        this.status,
        this.tsunami,
        this.sig,
        this.net,
        this.code,
        this.ids,
        this.sources,
        this.types,
        this.nst,
        this.dmin,
        this.rms,
        this.gap,
        this.magType,
        this.type,
        this.title,
    });

    double mag;
    String place;
    int time;
    int updated;
    dynamic tz;
    String url;
    String detail;
    int felt;
    double cdi;
    double mmi;
    String alert;
    Status status;
    int tsunami;
    int sig;
    String net;
    String code;
    String ids;
    String sources;
    String types;
    int nst;
    double dmin;
    double rms;
    double gap;
    String magType;
    PropertiesType type;
    String title;

    // Changed null values = 0
    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mag: json["mag"].toDouble(),
        place: json["place"],
        time: json["time"],
        updated: json["updated"],
        tz: json["tz"],
        url: json["url"],
        detail: json["detail"],
        felt: json["felt"] == null ? 0 : json["felt"],
        cdi: json["cdi"] == null ? 0.0 : json["cdi"].toDouble(),
        mmi: json["mmi"] == null ? 0.0 : json["mmi"].toDouble(),
        alert: json["alert"] == null ? "" : json["alert"],
        status: statusValues.map[json["status"]],
        tsunami: json["tsunami"],
        sig: json["sig"],
        net: json["net"],
        code: json["code"],
        ids: json["ids"],
        sources: json["sources"],
        types: json["types"],
        nst: json["nst"] == null ? 0 : json["nst"],
        dmin: json["dmin"] == null ? 0 : json["dmin"].toDouble(),
        rms: json["rms"].toDouble(),
        gap: json["gap"] == null ? 0 : json["gap"].toDouble(),
        magType: json["magType"],
        type: propertiesTypeValues.map[json["type"]],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "mag": mag,
        "place": place,
        "time": time,
        "updated": updated,
        "tz": tz,
        "url": url,
        "detail": detail,
        "felt": felt == null ? 0 : felt,
        "cdi": cdi == null ? 0 : cdi,
        "mmi": mmi == null ? 0 : mmi,
        "alert": alert == null ? "" : alert,
        "status": statusValues.reverse[status],
        "tsunami": tsunami,
        "sig": sig,
        "net": net,
        "code": code,
        "ids": ids,
        "sources": sources,
        "types": types,
        "nst": nst == null ? 0 : nst,
        "dmin": dmin == null ? 0 : dmin,
        "rms": rms,
        "gap": gap == null ? 0 : gap,
        "magType": magType,
        "type": propertiesTypeValues.reverse[type],
        "title": title,
    };
}

enum Status { AUTOMATIC, REVIEWED }

final statusValues = EnumValues({
    "automatic": Status.AUTOMATIC,
    "reviewed": Status.REVIEWED
});

enum PropertiesType { EARTHQUAKE }

final propertiesTypeValues = EnumValues({
    "earthquake": PropertiesType.EARTHQUAKE
});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({
    "Feature": FeatureType.FEATURE
});

class Metadata {
    Metadata({
        this.generated,
        this.url,
        this.title,
        this.status,
        this.api,
        this.count,
    });

    int generated;
    String url;
    String title;
    int status;
    String api;
    int count;

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        generated: json["generated"],
        url: json["url"],
        title: json["title"],
        status: json["status"],
        api: json["api"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "generated": generated,
        "url": url,
        "title": title,
        "status": status,
        "api": api,
        "count": count,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
