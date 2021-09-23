class Project {
  int? id;
  String? image;
  String? rating;
  String? startedAt;
  String? endAt;
  int? forMembers;
  String title;
  int? category;
  int? subcategory;
  String? location;
  int? countMembers;
  String? description;

  Project({ 
    this.id, 
    this.image,
    this.rating, 
    this.startedAt, 
    this.endAt, 
    this.forMembers, 
    this.title = '', 
    this.category, 
    this.subcategory, 
    this.countMembers, 
    this.location, 
    this.description
  });

  String? datesOf() {
    return '${this.startedAt}-${this.endAt}';
  }
}