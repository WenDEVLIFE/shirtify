class Ordermodel {
  final String id;
  final String productname;
  final String image;
  final String size;
  final double price;
  final int quantity;
  final int total;
  final String paidService;
  final String orderDate;
  final String orderTime;


  Ordermodel({
    required this.id,
    required this.productname,
    required this.image,
    required this.size,
    required this.price,
    required this.quantity,
    required this.total,
    required this.paidService,
    required this.orderDate,
    required this.orderTime
  });
}