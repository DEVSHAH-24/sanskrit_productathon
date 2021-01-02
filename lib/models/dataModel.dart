class DataModel {
  final String name;
  final String email;
  final String photoUrl;
  final String userId;
  final String label;
  final List<String> connectedUserIds;
  final String bio;
  final Map<String, List<String>> requestedIds;

  const DataModel({
    this.name,
    this.email,
    this.photoUrl,
    this.userId,
    this.label,
    this.connectedUserIds,
    this.bio,
    this.requestedIds
  });
}
