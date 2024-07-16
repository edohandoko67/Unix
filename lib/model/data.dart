class DataUser {
  String name;
  int money;
  String date;

  DataUser({
   required this.name,
   required this.money,
   required this.date
});
  Map<String, dynamic> toMap() {
    return {
      'nama': name,
      'uang': money,
      'tanggal': date,
    };
  }
}