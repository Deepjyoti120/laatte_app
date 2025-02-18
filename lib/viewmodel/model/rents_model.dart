import 'package:laatte/viewmodel/model/billing.dart';

class Rent {
  List<Billing>? monthlyBilling;
  List<Billing>? yearlyHistory;

  Rent({this.monthlyBilling, this.yearlyHistory});

  Rent.fromJson(Map<String, dynamic> json) {
    if (json['monthlyBilling'] != null) {
      monthlyBilling = <Billing>[];
      json['monthlyBilling'].forEach((v) {
        monthlyBilling!.add(Billing.fromJson(v));
      });
    }
    if (json['yearlyHistory'] != null) {
      yearlyHistory = <Billing>[];
      json['yearlyHistory'].forEach((v) {
        yearlyHistory!.add(Billing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monthlyBilling != null) {
      data['monthlyBilling'] = monthlyBilling!.map((v) => v.toJson()).toList();
    }
    if (yearlyHistory != null) {
      data['yearlyHistory'] = yearlyHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
