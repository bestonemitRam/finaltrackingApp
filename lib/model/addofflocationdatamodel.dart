class AddLocation {
  final String latitude;
  final String longitude;

  AddLocation({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
