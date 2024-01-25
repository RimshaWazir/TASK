enum Availability { AVAILABILITY_TRUE, FALSE, TRUE }

final availabilityValues = EnumValues({
  "True": Availability.AVAILABILITY_TRUE,
  " False": Availability.FALSE,
  " True": Availability.TRUE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
