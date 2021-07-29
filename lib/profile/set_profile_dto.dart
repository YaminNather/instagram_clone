class SetProfileDTO {
  const SetProfileDTO(this.userId, this.username, this.bio, {this.dpURL, this.dpPath});


   final String userId;
  final String username;
  final String bio;
  final String? dpURL;
  final String? dpPath;
}