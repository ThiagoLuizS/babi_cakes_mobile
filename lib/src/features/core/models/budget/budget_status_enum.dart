import 'dart:convert' as convert;

class BudgetStatusEnum {
  late String status;

  BudgetStatusEnum({required this.status});

  BudgetStatusEnum.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}