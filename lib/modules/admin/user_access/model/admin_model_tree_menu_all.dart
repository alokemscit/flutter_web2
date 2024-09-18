class ModelTreeMenuAll {
  int? id;
  int? pId;
  String? name;
  int? sl;
  bool? checked;
  bool? isParent;

  ModelTreeMenuAll({this.id, this.pId, this.name, this.sl, this.checked,this.isParent});

  ModelTreeMenuAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pId = json['pId'];
    name = json['name'];
    sl = json['sl'];
    checked = json['checked']==1?true:false;
    isParent=json['isparent']==1?true:false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pId'] = this.pId;
    data['name'] = this.name;
    data['sl'] = this.sl;
    data['checked'] = this.checked==true?1:0;
    data['isparent']= this.isParent==true?1:0;

    return data;
  }
}