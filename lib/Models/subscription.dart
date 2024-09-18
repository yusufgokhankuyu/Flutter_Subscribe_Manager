class Subscription {
  var ID;
  var platform_Name;
  var start_Date;
  var finish_Date;
  var frequency;
  Subscription(
      this.platform_Name, this.start_Date, this.finish_Date, this.frequency);
  Subscription.withID(this.ID, this.platform_Name, this.start_Date,
      this.finish_Date, this.frequency);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = ID;
    map['platform_Name'] = platform_Name;
    map['start_Date'] = start_Date;
    map['finish_Date'] = finish_Date;
    map['frequency'] = frequency;

    return map;
  }

  Subscription.fromMap(Map<String, dynamic> map) {
    ID = map['ID'];
    platform_Name = map['platform_Name'];
    start_Date = map['start_Date'];
    finish_Date = map['finish_Date'];
    frequency = map['frequency'];
  }

  @override
  String toString() {
    return 'Subscription{ID: $ID , platform_Name: $platform_Name, start_Date : $start_Date, finish_Date : $finish_Date, frequency : $frequency}';
  }
}
