class DataModel {
  final String name;
  final String email;
  final String photoUrl;
  final String userId;
  final String label;
  final List<String> connectedUserIds;
  final String bio;

  const DataModel({
    this.name,
    this.email,
    this.photoUrl,
    this.userId,
    this.label,
    this.connectedUserIds,
    this.bio,
  });
}
