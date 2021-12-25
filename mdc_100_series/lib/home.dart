// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());
    
    return products.map((product) {
      return Card(
            elevation: 0.0,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0/11.0,
                  child: Image.asset(
                    product.assetName,
                    package: product.assetPackage,
                    fit: BoxFit.fitWidth,
                  ),  
                ),
                Expanded(
                  child: 
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            product.name,
                            style: theme.textTheme.button,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            formatter.format(product.price),
                            style: theme.textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          );
    }).toList();
  }

  // TODO: Make a collection of cards (102)
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      // TODO: Add app bar (102)
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, semanticLabel: 'menu',),
          onPressed: () {
            print('Menu button');
          }
        ,),
        title: const Text('SHRINE'),
        actions: <Widget>[
          IconButton(onPressed: () {
            print('Search button');
          }, icon: const Icon(Icons.search, semanticLabel: 'search',)),
          IconButton(onPressed: () {
            print('Filter button');
          }, icon: const Icon(Icons.tune, semanticLabel: 'filter',)),
        ],
      ),
      // TODO: Add a grid view (102)
      // body: GridView.count(
      //   crossAxisCount: 2,
      //   padding: const EdgeInsets.all(16.0),
      //   childAspectRatio: 8.0/9.0,
      //   children: _buildGridCards(context),
      // ),
      body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all),),
      // TODO: Set resizeToAvoidBottomInset (101)
      resizeToAvoidBottomInset: false,
    );
  }
}
