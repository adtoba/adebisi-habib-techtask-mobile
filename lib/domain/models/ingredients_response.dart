class IngredientsResponse {
  String? title;
  String? useBy;

  IngredientsResponse({this.title, this.useBy});

  IngredientsResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    useBy = json['use-by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['use-by'] = this.useBy;
    return data;
  }
}
