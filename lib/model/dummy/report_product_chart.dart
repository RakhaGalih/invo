class ChartData {
  final int x;
  final double stockIn;
  final double stockOut;

  ChartData(this.x, this.stockIn, this.stockOut);
}

class ProductData {
  final int product;
  final int stockIn;
  final int stockOut;
  final String revenue;

  ProductData(this.product, this.stockIn, this.stockOut, this.revenue);
}