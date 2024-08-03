import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../resources/colors.dart';
import '../../resources/styles.dart';
import '../data/firestore/bloc/products/f_products_bloc.dart';
import '../data/firestore/bloc/products/f_products_state.dart';
import '../data/firestore/f_products_model.dart';

class CategoryProduct extends StatefulWidget {
  final String searchQuery;

  const CategoryProduct({required this.searchQuery, super.key});

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreProductsBloc, FirestoreProductsState>(
      builder: (context, state) {
        if (state is FirestoreProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FirestoreProductsLoadedState) {
          List<FirestoreProductModel> filteredProducts =
              _filterProducts(state.products);
          return _buildContent(context, filteredProducts);
        } else if (state is FirestoreProductsErrorState) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }

  List<FirestoreProductModel> _filterProducts(
      List<FirestoreProductModel> products) {
    List<FirestoreProductModel> filteredByCategory;
    if (_selectedCategory == 'All') {
      filteredByCategory = products;
    } else {
      filteredByCategory = products
          .where((product) =>
              product.category.toLowerCase() == _selectedCategory.toLowerCase())
          .toList();
    }
    if (widget.searchQuery.isNotEmpty) {
      return filteredByCategory
          .where((product) => product.title
              .toLowerCase()
              .contains(widget.searchQuery.toLowerCase()))
          .toList();
    }
    return filteredByCategory;
  }

  Widget _buildContent(
      BuildContext context, List<FirestoreProductModel> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Styles.title
              .copyWith(fontWeight: FontWeight.w600, color: primaryText),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryChip(context, 'All'),
              _buildCategoryChip(context, "men's clothing"),
              _buildCategoryChip(context, "women's clothing"),
              _buildCategoryChip(context, 'jewelery'),
              _buildCategoryChip(context, 'electronics'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildGridView(products),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = label;
          });
        },
        child: Chip(
          label: Text(
            label,
            style: Styles.category,
          ),
          backgroundColor: _selectedCategory == label ? primaryText : cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: cardColor, width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(List<FirestoreProductModel> products) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return _buildGridItem(context, products[index]);
      },
      itemCount: products.length,
    );
  }

  Widget _buildGridItem(BuildContext context, FirestoreProductModel product) {
    return InkWell(
      onTap: () {
        context.push('/detail/${product.documentId}');
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
            child: Center(
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                width: 150.0,
                height: 150.0,
              ),
            ),
          ),
          Positioned(
            left: 16.0,
            top: 16.0,
            right: 16.0,
            child: Text(
              product.title,
              style: Styles.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: Text(
              '\$${product.price}',
              style: Styles.title,
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: primaryText,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                ),
              ),
              child: const Icon(
                Icons.navigate_next,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
