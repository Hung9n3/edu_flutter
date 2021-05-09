class DepartmentPost {
  final String name;
  final String shortName;
  DepartmentPost(this.name, this.shortName);

  // DepartmentPost.fromJson(Map<String, dynamic> json)
  //     : _startDate =  json['startDate'],
  //       _endDate = json['endDate'],
  //       _goalList = json['goalList'],
  //       _improvement = json['improvement'];

  Map<String, dynamic> toJson() =>
      {
         'name': name,
        'shortName': shortName,
      };
}