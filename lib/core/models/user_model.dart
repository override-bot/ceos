class Ceo {
  final String? id;
  final String? firstname;
  final String? lastname;
  final int? ceoScore;
  final String? phoneNumber;
  final String? instagramLink;
  final String? whatsappLink;
  final String? twitterLink;
  final String? bio;
  final String? imageUrl;
  final String? username;
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
      this.whatsappLink,
      this.username});
  Ceo.fromMap(Map snapshot, this.id)
      : bio = snapshot['bio'],
        ceoScore = snapshot['ceoScore'],
        username = snapshot['username'],
        firstname = snapshot['firstname'],
        lastname = snapshot['lastname'],
        imageUrl = snapshot['imageUrl'],
        instagramLink = snapshot['instagramLink'],
        phoneNumber = snapshot['phoneNumber'],
        whatsappLink = snapshot['whatsappLink'],
        twitterLink = snapshot['twitterLink'];
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
      'username': username
    };
  }
}
