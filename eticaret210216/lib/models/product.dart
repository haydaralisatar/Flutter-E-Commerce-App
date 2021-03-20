class product {
  int _id;

  int get id => _id;
  set id(int value) {
    _id = value;
  }

  String get salesStartDate => _salesStartDate;
  set salesStartDate(String value) {
    _salesStartDate = value;
  }

  int get qtyInStock => _qtyInStock;

  set qtyInStock(int value) {
    _qtyInStock = value;
  }
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String get status => _status;
  set status(String value) {
    _status = value;
  }
  String get description => _description;
  set description(value) {
    _description = value;
  }

  double get price => _price;
  set price(double value) {
    _price = value;
  }


  String _name, _description;
  String _salesStartDate;
  double _price;
  int _qtyInStock;
  String _status;
  product(this._name, this._description, this._price,this._salesStartDate,this._qtyInStock,this._status);
  product.withId(this._id, this._name, this._description, this._price,this._salesStartDate,this._qtyInStock,this._status);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": _name,
      "description": _description,
      "price": _price,
      "salesStartDate" :_salesStartDate,
      "qtyInStock" : _qtyInStock,
      "status": _status
    };
    if(id != null)
      map["id"]=_id;

    return map;
  }

  product.fromObject(dynamic o)
  {
    this._id = o["id"];
    this._name = o["name"];
    this._description= o["description"];
    this._price= o["price"];
    this._salesStartDate = o["salesStartDate"];
    this._qtyInStock = o["qtyInStock"];
    this._status = o["status"];
  }
}