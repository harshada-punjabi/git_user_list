class GitUserLandingErrorDto {
  List<String> errors;

  GitUserLandingErrorDto({this.errors});

  GitUserLandingErrorDto.fromJson(Map<String, dynamic> json) {
    List<dynamic> errorsList = json['errors'];
    this.errors = [];
    this.errors.addAll(errorsList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errors'] = this.errors;
    return data;
  }
}
