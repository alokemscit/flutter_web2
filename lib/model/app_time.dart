class AppTime {
  final String id;
  final String name;
  final String designation;
  final String stime;
  final String status;
  final String image;
  final String comments;
  final String date;
  final int sl;
  AppTime( 
      {required this.id,
      required this.name,
      required this.designation,
      required this.stime,
      required this.status,
      required this.image,
      required this.comments,
      required this.sl,required this.date,});

  // @override
  // int get hashCode => id.hashCode ^ name.hashCode ^ stime.hashCode;
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is AppTime &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         name == other.name &&
  //         stime == other.stime;
}

class DistinctDoctor {
  final String id;
  DistinctDoctor({required this.id});
  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistinctDoctor &&
          runtimeType == other.runtimeType &&
          id == other.id;
}
