import 'package:flutter/material.dart';
import 'models/product.dart';
import 'db/dbHelper.dart';
import 'screens/ProductList.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return MyHomePageState();
  }

}

class MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce App"),
      ),
      body: ProductList(),
    );
  }
}