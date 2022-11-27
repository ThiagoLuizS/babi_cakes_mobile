import 'dart:convert' as convert;

class FilterParam {
  late String? name;
  late String? param ;
  late bool selected = false;

  FilterParam({this.name, this.param = "value,desc"});

  static List<FilterParam> listFilterProduct = [
    FilterParam(name: "Maior preço", param: "value,desc", ),
    FilterParam(name: "Menor preço", param: "value,asc", ),
    FilterParam(name: "A-Z", param:  "name,asc", ),
  ];
}