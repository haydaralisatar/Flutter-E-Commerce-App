import 'package:flutter/foundation.dart';
import 'package:eticaret210216/db/dbHelper.dart';
import 'package:eticaret210216/models/product.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:intl/intl.dart' as intl;

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProductState();
  }
}

class AddProductState extends State {
  dbHelper db = new dbHelper();
  DateTime date = DateTime.now();
  bool enableFeature = false;
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  double price=0;
  TextEditingController txtQtyInStock = new TextEditingController();
  TextEditingController txtSalesStartDate = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Form widgets'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        TextFormField(
                          controller: txtName,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Enter a title...',
                            labelText: 'Title',
                          ),
                        ),
                        TextFormField(
                          controller: txtDescription,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a description...',
                            labelText: 'Description',
                          ),
                          maxLines: 5,
                        ),
                        TextFormField(
                          controller: txtQtyInStock,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Enter a Quantity...',
                            labelText: 'Quantity',
                          ),
                        ),
                        _FormDatePicker(
                          date: date,
                          onChanged: (value) {
                            setState(() {
                              date = value;
                            });
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            Text(
                              intl.NumberFormat.currency(
                                  symbol: "\$", decimalDigits: 0)
                                  .format(price),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Slider(
                              min: 0,
                              max: 3000,
                              divisions: 3000,
                              value: price,
                              onChanged: (value) {
                                setState(() {
                                  price = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: status,
                              onChanged: (checked) {
                                setState(() {
                                  status = checked;
                                });
                              },
                            ),
                            Text('Status',
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                      ].expand(
                            (widget) => [
                          widget,
                          SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.update),
        onPressed: (){
          insert();
        },
      ),
    );
  }

  void insert() async{
    product pro = new product(txtName.text, txtDescription.text, price, date.toString(),int.parse(txtQtyInStock.text),status.toString());
    print(pro);
    int result = await db.insert(pro);
    if(result !=0){
      Navigator.pop(context,true);
      AlertDialog alertDialog =new AlertDialog(
        title: Text("Başarılı"),
        content: Text("Yeni ürün başarıyla eklendi : ${txtName.text}" ),
      );

      showDialog(context: context, builder: (_)=>alertDialog);
    }
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged onChanged;

  _FormDatePicker({
    this.date,
    this.onChanged,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        FlatButton(
          child: Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
