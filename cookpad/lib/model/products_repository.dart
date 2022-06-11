import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts() {

    return <Product>[
      const Product(
        productName: 'Пицца 1',
        authorName: 'Автор 1',
        productPreview: 'pizza1.jpg',
        authorPreview: 'author1.jpg',
      ),
      const Product(
        productName: 'Пицца 2',
        authorName: 'Автор 2',
        productPreview: 'pizza2.jpg',
        authorPreview: 'author2.jpg',
      ),
      const Product(
        productName: 'Пицца 3',
        authorName: 'Автор 3',
        productPreview: 'pizza3.jpg',
        authorPreview: 'author3.jpg',
      ),
      const Product(
        productName: 'Пицца 4',
        authorName: 'Автор 1',
        productPreview: 'pizza4.jpg',
        authorPreview: 'author1.jpg',
      ),
      const Product(
        productName: 'Пицца 5',
        authorName: 'Автор 2',
        productPreview: 'pizza5.jpg',
        authorPreview: 'author2.jpg',
      ),
      const Product(
        productName: 'Пицца 6',
        authorName: 'Автор 3',
        productPreview: 'pizza6.jpg',
        authorPreview: 'author3.jpg',
      ),
    ];
  }
}
