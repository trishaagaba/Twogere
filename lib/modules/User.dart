class User{

  final int id;
  final String name;
  final String email;
  final String phone;
  final String gender;  


  User({
    required this.email,
    required this.name,
    required this.gender,
    required this.id,
    required this.phone
  });

  factory User.fromJson(Map<String, dynamic> json)
    => User(
      email: json['email'], 
      name: json['name'], 
      gender: json['gender'], 
      id: json['id'], 
      phone: json['phone']);


    Map<String, dynamic> toJson()
      => {
        "email": email,
        "name": name,
        "gender": gender,
        "id": id,
        "phone": phone
      };

}