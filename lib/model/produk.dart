class Produk {
  int? id;
  String? source;
  int? amount;
  int? frequency;
  Produk({this.id, this.source, this.amount, this.frequency});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        source: obj['source'],
        amount: obj['amount'],
        frequency: obj['frequency']);
  }
}
