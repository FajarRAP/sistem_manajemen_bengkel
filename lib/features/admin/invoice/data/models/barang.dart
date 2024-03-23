class Barang {
  final String nama;
  final int harga;
  final int n;

  int getSubTotal() => harga * n;

  Barang({
    required this.nama,
    required this.harga,
    required this.n,
  });
}
