extension IntPriceExtension on int {
  String toFormattedPrice() {
    return '${toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')} đ';
  }
}
