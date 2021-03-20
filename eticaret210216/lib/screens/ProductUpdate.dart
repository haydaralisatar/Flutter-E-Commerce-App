import 'package:eticaret210216/screens/ProductList.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:intl/intl.dart' as intl;
import '../models/product.dart';
import '../db/dbHelper.dart';
import '../main.dart';

class FormWidgetsDemo extends StatefulWidget {
  FormWidgetsDemo({Key key, this.Product});
  final product Product;
  @override
  _FormWidgetsDemoState createState() => _FormWidgetsDemoState();

}

class _FormWidgetsDemoState extends State<FormWidgetsDemo> {
  final _formKey = GlobalKey<FormState>();
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
                          initialValue: widget.Product.name,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Enter a title...',
                            labelText: 'Title',
                          ),
                          onChanged: (value) {
                            setState(() {
                              widget.Product.name = value;
                            });
                          },
                        ),
                        TextFormField(
                          initialValue: widget.Product.description,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            hintText: 'Enter a description...',
                            labelText: 'Description',
                          ),
                          onChanged: (value) {
                            widget.Product.description = value;
                          },
                          maxLines: 5,
                        ),
                        TextFormField(
                          initialValue: widget.Product.qtyInStock.toString(),
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Enter a Quantity...',
                            labelText: 'Quantity',
                          ),
                          onChanged: (value) {
                            widget.Product.qtyInStock = int.parse(value);
                          },
                        ),
                        _FormDatePicker(
                          date: DateTime.parse(widget.Product.salesStartDate),
                          onChanged: (value) {
                            setState(() {
                              widget.Product.salesStartDate = value.toString();

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
                                  .format(widget.Product.price),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Slider(
                              min: 0,
                              max: 3000,
                              divisions: 3000,
                              value: widget.Product.price,
                              onChanged: (value) {
                                setState(() {
                                  widget.Product.price = value;
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
                              value:  a(widget.Product.status),
                              onChanged: (checked) {
                                setState(() {
                                  widget.Product.status = checked.toString();
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
          dbHelper db= new dbHelper();
         var a= db.update(widget.Product.id,widget.Product);
         Navigator.pop(context);
         Navigator.push(context,MaterialPageRoute(builder: (context)=> MyApp()));
        },
      ),
    );
  }
  bool a(String b){
    if(b == "true")
      {
        return true;
      }
    else{
      return false;
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
