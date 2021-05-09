class DepartmentGet {
   int Id;
   String name;
   String shortName;
DepartmentGet(this.shortName, this.Id, this.name);
   DepartmentGet.fromJson(Map<String, dynamic> json)
   {    name = json['name'];
        Id = json['id'] ;
        shortName = json['shortName'];
   }

}
