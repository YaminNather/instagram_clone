import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_ui_clone/widgets/search_bar_widget.dart';

class WSearchPage extends StatefulWidget {
  const WSearchPage({ Key? key }) : super(key: key);

  @override
  _WSearchPageState createState() => _WSearchPageState();
}

class _WSearchPageState extends State<WSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(      
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(child: _buildSearchBar()),

                IconButton(icon: const Icon(EvaIcons.squareOutline), onPressed: () {})
              ],
            )
          ),

          _buildCategories(),
          
          Expanded(child: _buildPics())
        ]
      ),
    );
  }

  Widget _buildSearchBar() => const WSearchBar();

  Widget _buildCategories() {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal, itemCount: categories.length,
        itemBuilder: (_, index) => _buildCategoryButton(categories[index])
      ),
    );
  }

  Widget _buildCategoryButton(final String category) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(child: Text(category), onPressed: () {}),

        const SizedBox(width: 8.0)
      ]
    ); 
  }

  Widget _buildPics() {
    return new StaggeredGridView.countBuilder(
      itemCount: 9,      
      crossAxisCount: 3,
      itemBuilder: (_, index) {
        final String url = urls[index];

        return Image.network(url, fit: BoxFit.cover);
      },
      mainAxisSpacing: 2.0, crossAxisSpacing: 2.0,
      staggeredTileBuilder: (i) {
        final int count;
        if((i ~/ 3) % 2 == 0)
          count = ((i + 3) % 3 == 0) ? 2 : 1;
        else
          count = ((i + 3) % 3 == 1) ? 2 : 1;

        return new StaggeredTile.count(count, count.toDouble() );
      }
    );
  }
}

const List<String> categories = [
  "IGTV",
  "Shop",
  "Style",
  "Sports",
  "Auto"  
];

const List<String> urls = [
  "https://images.pexels.com/photos/1139641/pexels-photo-1139641.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
  "https://images.unsplash.com/photo-1604004215402-e0be233f39be",
  "https://images.unsplash.com/photo-1602563010363-c3d0dfda9554",
  "https://images.unsplash.com/photo-1613925522568-68c75a4b622a",
  "https://images.unsplash.com/photo-1615084653006-304772431593",
  "https://images.unsplash.com/photo-1603771550832-00a3f5b09159",
  "https://images.unsplash.com/photo-1570721464498-29cabea4b296",
  "https://i.pinimg.com/564x/58/a5/8e/58a58e2348f04cc04fe83a18d710950e.jpg",
  "https://i.pinimg.com/564x/16/55/a7/1655a788d6b02fb58df12c343811a3ec.jpg"
];