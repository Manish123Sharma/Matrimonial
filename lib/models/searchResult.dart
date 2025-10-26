class SearchResult {
  final int profileId;
  final String name;
  final String age;
  final String gotra;
  final String education;
  final String incomeCategory;
  final String defaultPhoto;

  SearchResult({
    required this.profileId,
    required this.name,
    required this.age,
    required this.gotra,
    required this.education,
    required this.incomeCategory,
    required this.defaultPhoto,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      profileId: json['ProfileId'] ?? 0,
      name: json['Name'] ?? '',
      age: json['Age'] ?? '',
      gotra: json['Gotra'] ?? '',
      education: json['Education'] ?? '',
      incomeCategory: json['IncomeCategory'] ?? '',
      defaultPhoto: json['DefaultPhoto'] ?? '',
    );
  }
}
