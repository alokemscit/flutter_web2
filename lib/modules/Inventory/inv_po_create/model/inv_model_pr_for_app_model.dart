// ignore_for_file: public_member_api_docs, sort_constructors_first
class ModelInvPrForApp {
  String? id;
  String? month_name;
  String? pr_no;
  String? priority_name;
  String? pr_date;
  String? remarks;
  ModelInvPrForApp(
      {this.id,
      this.month_name,
      this.pr_no,
      this.pr_date,
      this.priority_name,
      this.remarks});
  ModelInvPrForApp.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    month_name = json['month_name'].toString();
    pr_no = json['pr_no'];
    priority_name = json['priority_name'];
    remarks = json['remarks'];
    pr_date = json['pr_date'];
  }
}
