enum OrderType {
  delivery,
  pickup,
}

class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  }) {
    if (price < 0) {
      throw ArgumentError('Price cannot be negative!');
    }
  }

  @override
  String toString() => '$name (\$${price.toStringAsFixed(2)})';
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  }) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be positive!');
    }
  }

  double get subtotal => product.price * quantity;
}

class Order {
  final int orderId;
  final OrderType orderType;
  final String? deliveryAddress;
  final List<OrderItem> items = [];

  Order({
    required this.orderId,
    required this.orderType,
    this.deliveryAddress,
  }) {
    if (orderType == OrderType.delivery &&
        (deliveryAddress == null ||
            deliveryAddress!.trim().isEmpty)) {
      throw ArgumentError(
        'A delivery address is required for delivery orders!',
      );
    }

    if (orderType == OrderType.pickup &&
        deliveryAddress != null) {
      throw ArgumentError(
        'Pickup orders do not need a delivery address!',
      );
    }
  }

  void addItem(Product product, int quantity) {
    items.add(
      OrderItem(product: product, quantity: quantity),
    );
  }

  double calculateTotal() {
    double total = 0;

    for (final item in items) {
      total += item.subtotal;
    }

    return total;
  }

  // Getter for convenient access to the total
  double get totalAmount => calculateTotal();

  void displayOrder() {
    print('Order ID: $orderId');
    print('Order type: ${orderType.name}');

    if (orderType == OrderType.delivery) {
      print('Delivery address: $deliveryAddress');
    }

    print('Items:');

    for (final item in items) {
      print(
        '${item.product.name} x ${item.quantity} '
        '= \$${item.subtotal.toStringAsFixed(2)}',
      );
    }

    print('Total amount: \$${totalAmount.toStringAsFixed(2)}');
  }
}

void main() {
  // Create products
  final laptop = Product(name: 'Laptop', price: 800.00);
  final mouse = Product(name: 'Mouse', price: 25.00);
  final keyboard = Product(name: 'Keyboard', price: 45.00);

  final order1 = Order(
    orderId: 1,
    orderType: OrderType.delivery,
    deliveryAddress: '123 Main Street, Phnom Penh',
  );

  order1.addItem(laptop, 1);
  order1.addItem(mouse, 2);

  order1.displayOrder();

  print('');

  final order2 = Order(
    orderId: 2,
    orderType: OrderType.pickup,
  );

  order2.addItem(keyboard, 1);
  order2.addItem(mouse, 1);

  order2.displayOrder();

  print('');
  print('Order 1 total: \$${order1.totalAmount.toStringAsFixed(2)}');
  print('Order 2 total: \$${order2.totalAmount.toStringAsFixed(2)}');
}
