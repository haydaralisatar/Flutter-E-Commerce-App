import 'package:flutter/material.dart';
import '../db/dbHelper.dart';
import '../models/product.dart';
import '../screens/ProductDetail.dart';
import '../screens/AddProduct.dart';
class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductListState();
  }

}

class ProductListState extends State<ProductList> {
  dbHelper db = new dbHelper();
  List<product> products;
  int productCount=0;
  @override
  Widget build(BuildContext context) {
    if(products == null)
      {
        products = new List<product>();
        print("sa");
        getProducts();
      }
    return Scaffold(
      body: productList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goAddProduct();},
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }
  ListView productList(){
    if(productCount>0)
      {
        print(productCount);
        return ListView.builder(
          itemCount: productCount,
          shrinkWrap: true,
          reverse: true,
          itemBuilder: (BuildContext context, int possition)
          {
            print(this.products[possition].name);
            return Card(
              color: Colors.amberAccent,
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(this.products[possition].name.substring(0,1)),
                ),
                title: Text(this.products[possition].name),
                subtitle: Text(this.products[possition].description+"\n"+this.products[possition].price.toString()),
                onTap: (){
                  goDetail(this.products[possition]);},
              ),
            );
          },
        );
      }
  }
  void goDetail(product Product) async {
    bool resp= await  Navigator.push(context,MaterialPageRoute(builder: (context)=> ProductDetail(Product)));
    if( resp != null) {
      if(resp) {
        getProducts();
      }
    }
  }

  void getProducts(){
    var dbFuture = db.dbCreate();
    dbFuture.then((resp){
      var productsFuture = db.getProducts();
      productsFuture.then((data) {
        List<product> productsData =new List<product>();
        for (int i =0; i<data.length; i++)
          {
            print(data[i]);
            productsData.add(product.fromObject(data[i]));
          }
        setState(() {
          products = productsData;
          productCount = productsData.length;
        });
      } );
    } );
  }
  void goAddProduct() async {
    bool result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }
}