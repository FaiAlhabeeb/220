class Post {
  late int id;
  late String position;
  late String workplaceType;
  late String jobType;
  late String location;
  late String description;

  Post();

  Post.fromMap(Map<String, dynamic> map) {
    position = map['position'];
    workplaceType = map['workplaceType'];
    jobType = map['jobType'];
    location = map['location'];
    description = map['description'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['position'] = position;
    map['workplaceType'] = workplaceType;
    map['jobType'] = jobType;
    map['location'] = location;
    map['description'] = description;
    return map;
  }
}