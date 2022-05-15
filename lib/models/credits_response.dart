// To parse this JSON data, do
//
//     final credistResponse = credistResponseFromMap(jsonString);

import 'dart:convert';

class CredistResponse {
  CredistResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory CredistResponse.fromJson(String str) => CredistResponse.fromMap(json.decode(str));

  factory CredistResponse.fromMap(Map<String, dynamic> json) => CredistResponse(
    id: json["id"],
    cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
  );
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    this.department,
    required this.job,
  });

  bool adult;
  int gender;
  int id;
  String? knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"],
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
    department: json["department"],
    job: json["job"],
  );

  get fullProfilePath{
    if(profilePath != null)return 'https://image.tmdb.org/t/p/w500$profilePath';

    return 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALcAAAETCAMAAABDSmfhAAAANlBMVEXMzMzPz8/Ly8vIyMiUlJSXl5fCwsKtra27u7vFxcW1tbW+vr6ampqvr6+ioqKWlpanp6eOjo5WodGlAAAFRUlEQVR4nO2c3ZLkJgyFEWD+Ecz7v2wkjKd7ktndciXlra2c76Ib2xgOspB9dYwBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA8CdAwteG+Wx815d+eNujBB6tO22V4blqI7WPlr7ra0vzu7OL3s+sre49h6fUvqT4g9lHq/M3PpooKEfjdnwnPHqezXfpbKdnHtMZinLbeFw4dV/IzVYpH2wojW4cN0d1zHXdBYmpzcGugxGNdD7kVPXR2DiqyX7qkypP6+ZDfpJPVEYi4ybn1ESEjWcIg2drMp8ZEVpdK5UrUR9Mbd0UPZIO7mHdc9Kpe3qnCcxh6ZIcX4kiaZBMaWntPJekS54tG2qsx3Na9ua1ygcJMqHtRxXdZm282ocGNx3l1Hpwba9ohj65WEMHkyY5Wz600dvzO1PFTrcSRuSOFJfu4PvSLWnBO9yr64fXHUtedZt5uNa0UUZ9Xndv8pS3bsnyrvtONt4Zb9mmI9rPvjklZqki49TdZBNrQx7Y06odHzNoovulW/LEL907T4xpo1/hXv9VcuItT8bvyRPiofVYN6DTtwmH4utSsgt4kgK/RZW5eurTac2uMiJ1XBtShh7WnXYea2bTKmhh1UHeSqRy1CtR0hFIH1DS5xKItGImX0neufHpOsiHNdbqG7AdzupbSB59EDnx2pbJzh377CW1z/dO8NPlOQJZ35y889PDnyjU/CFIkZbo+bE+OSr74/rkyE0SOYwdzj5GG2de9eGlJTtUvmrG/lJ5Ujef6IuwTo46P4XJM+zs0aRwfe4Ml2Iy05k0hbnoaihN7k/L3l+mry9S87WxS8jb4TfN3/MdCwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4Jfk073PPu9295WbvnUUT7vEwD+5j35h60z/aNynlJJuxO5nuk9f4epSUSqF5UVoS5WTb1OEtGcMMrX6dxY1MqR0z5bYlx7V4vBLgN4MBmkd7PjJ36V7nqfe7/LrxKyldxk1UVwGsvWQrvPlCJ1iF6RrjTHOaE1YDtKOP25F/yCTY6LaZSIJhTXZGivDuhJXuGKKhbIcGA1dLPOKd9LrtGJVl1Esja1bVnTIokhUyQhzzs/V6o0xOXJyQ9b78ywUWq8yUPd3dZuewiyJK9WYTcxUmUT2KexjppBjT6LXiujLijUc6zoVXuveupVZ96gki6yyQBntpVv02SvuTu0vmTQE1nEYN3VTmLUXa5KqrYGLxFjOSVTU2dMHSb1uKctVDibzFe8swZJgtyAKlhTyy5VzvHSnNGmW8EV3v9I4LXNU8qI7x1qiuafbt8bFapBsI92lfZqmnqqttQ/RJaNRGXpArtGXfbnMbst08fQTpuFyzu4t3ok4Nfqhbl2tPfR6iZJdN/PEWGt031AWWSnGEKvarM5lILt193XgWH4+81t+NN629bgdRK/8ftNdfN+6dx9ND1rbOcSgQ8+VKo3zXd2rtyR3lgRZJru16bbs3TmtMypGtpDN09g4cxlbt++5LwfZctkgk3/pHqfuVYdO3VaXLhGRQaqV/FHT1pRLc+ejI3NT91mHZX+x1iYndcMuN2HXW5OkN8taOs+mtupucpx1x7tvw/U+r/lWV1pZo6NSf5VMGUygII/Glnacg0hDpwrnANRu6f60lb7K9XXq7cR7/X7rv/rml6s6vX7fbl3/lyEtvQ32tyn+zcvzPrIh/kSDW4r9YdPp/wjYCQPwv+Evdk8tYtEx45IAAAAASUVORK5CYII=';
  }
}
