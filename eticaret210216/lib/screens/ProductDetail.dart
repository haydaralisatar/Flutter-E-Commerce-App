import 'package:flutter/material.dart';
import '../db/dbHelper.dart';
import '../models/product.dart';
import '../screens/ProductUpdate.dart';

class ProductDetail extends StatefulWidget {
  product Product;
  ProductDetail(this.Product);
  @override
  State<StatefulWidget> createState() {
    return ProductDetailState(Product);
  }
}

dbHelper db = new dbHelper();
enum Option { Delete, Update }

class ProductDetailState extends State {
  product Product;
  ProductDetailState(this.Product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail : ${Product.name}"),
        actions: <Widget>[
          PopupMenuButton<Option>(
              onSelected: optionSelect,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>>[
                    PopupMenuItem<Option>(
                        value: Option.Delete, child: Text("Product Delete")),
                    PopupMenuItem(
                      value: Option.Update,
                      child: Text("Product Update"),
                    )
                  ])
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.shop),
                title: Text("Name : "+Product.name),
                subtitle: Text("Desciption : "+Product.description),
              ),
              const Divider(
                height: 50,
              ),
              ListTile(
                leading: Icon(Icons.money),
                title: Text("Price : "+Product.price.toString()),
                subtitle: Text("Quantity in Stock : "+Product.qtyInStock.toString()),
              ),
              const Divider(
                height: 50,
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text("Sales Start Date : "+DateTime.parse(Product.salesStartDate).toString()),
                subtitle: Text("Status : "+Product.status.toString()),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.shopping_basket),
        onPressed: (){
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Success"),
            content: Text("Product added to cart"),
          );
        },
      ),
    );
  }

  void optionSelect(Option option) async {
    int result;
    switch (option) {
      case Option.Delete:
        Navigator.pop(context, true);
        result = await db.delete(Product.id);
        print(result);
        if (result != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Success"),
            content: Text("Product deleted : ${Product.name}"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case Option.Update:
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FormWidgetsDemo(Product: Product,)));
        break;
      default:
    }
  }
}
