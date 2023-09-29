import 'package:apif/models/Product.dart';
import 'package:apif/services/AuthService.dart';
import 'package:apif/services/ProductService.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final productService = ProductService();
  final authService = AuthService();
  // Crie uma instância de ProductService

  late List<Product> productList; // Lista de produtos a serem exibidos

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Chamada para carregar os produtos ao iniciar a tela
  }

  Future<void> _loadProducts() async {
    final authToken = (await authService.getAuthToken()) ??
        ''; // Usar uma string vazia como valor padrão

    try {
      final fetchedProducts = await productService.fetchProducts(authToken);
      setState(() {
        productList = fetchedProducts; // Atualiza a lista de produtos
      });
    } catch (e) {
      // Trate os erros ao buscar a lista de produtos, se necessário
      print('Erro ao buscar a lista de produtos: $e');
    }
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
    );
  }
}
