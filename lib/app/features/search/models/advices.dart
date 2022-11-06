class Advices {
  String? aceh;
  String? indonesia;
  double? similiarity;

  Advices({this.aceh, this.indonesia, this.similiarity});

  factory Advices.fromJson(Map<String, dynamic> json) {
    var advice = Advices();
    advice.aceh = json['aceh'];
    advice.indonesia = json['indonesia'];

    if (json['similiarity'] == 1) {
      advice.similiarity = 1.0;
    } else {
      advice.similiarity = json['similiarity'];
    }

    return advice;
  }
}
