import 'package:apif/models/Product.dart';
import 'package:apif/pages/AddProduct_page.dart';
import 'package:apif/services/AuthService.dart';
import 'package:apif/services/ProductService.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final List<Product> products;

  ProductListScreen({required this.products});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final productService = ProductService();
  final authService = AuthService();

  late List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final authToken = (await authService.getAuthToken()) ?? '';

    try {
      final fetchedProducts = await productService.fetchProducts(authToken);
      setState(() {
        productList = fetchedProducts;
      });
    } catch (e) {
      print('Erro ao buscar a lista de produtos: $e');
    }
  }

  void updateProductList() {
    _loadProducts();
  }

  void _handleProductAdded() {
    // Chamada quando um novo produto é adicionado
    // Atualiza a lista de produtos
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: productList == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Exibe um indicador de carregamento enquanto os produtos estão sendo carregados
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Preço: ${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de cadastro de produtos
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddProductScreen(
                updateProductList: _loadProducts,
                context: context, // Passe o contexto aqui
              ),
            ),
          );
        },
        child: Icon(Icons.add), // Ícone de adição
      ),
    );
  }
}
