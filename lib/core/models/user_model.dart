class Ceo {
  String? id;
  String? firstname;
  String? lastname;
  int? ceoScore;
  String? phoneNumber;
  String? instagramLink;
  String? whatsappLink;
  String? twitterLink;
  String? bio;
  String? imageUrl;
  String? username;
  List? subscribers;
  Ceo(
      {this.id,
      this.bio,
      this.ceoScore,
      this.firstname,
      this.instagramLink,
      this.lastname,
      this.phoneNumber,
      this.twitterLink,
      this.imageUrl,
      this.subscribers,
      this.whatsappLink,
      this.username});
  Ceo.fromMap(Map snapshot, this.id)
      : bio = snapshot['bio'] ?? "",
        ceoScore = snapshot['ceoScore'] ?? 0,
        subscribers = snapshot['subscribers'] ?? [],
        username = snapshot['username'] ?? "",
        firstname = snapshot['firstname'] ?? "",
        lastname = snapshot['lastname'] ?? "",
        imageUrl = snapshot['imageUrl'] ?? "",
        instagramLink = snapshot['instagramLink'] ?? "",
        phoneNumber = snapshot['phoneNumber'] ?? "",
        whatsappLink = snapshot['whatsappLink'] ?? "",
        twitterLink = snapshot['twitterLink'] ?? "";
  toJson() {
    return {
      "bio": bio,
      'ceoScore': ceoScore,
      "firstname": firstname,
      'lastname': lastname,
      'instagramLink': instagramLink,
      'phoneNumber': phoneNumber,
      'whatsappLink': whatsappLink,
      'imageUrl': imageUrl,
      'twitterLink': twitterLink,
      'username': username,
      "subscribers": subscribers,
    };
  }
}
