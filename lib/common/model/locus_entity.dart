import 'dart:convert';

/// code : 1
/// data : [{"code":0,"imei":"866551032598729","lng":"113.777579","lat":"34.775200","speed":0,"course":0,"accStatus":false,"gpsTime":1615881206,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.776395","lat":"34.776319","speed":0,"course":0,"accStatus":false,"gpsTime":1615887962,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.776395","lat":"34.776319","speed":8,"course":0,"accStatus":false,"gpsTime":1615887996,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.777373","lat":"34.776107","speed":0,"course":0,"gpsTime":1615888038,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.777373","lat":"34.776107","speed":24,"course":0,"accStatus":false,"gpsTime":1615888056,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.778076","lat":"34.775607","speed":27,"course":70,"gpsTime":1615888060,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.779804","lat":"34.775973","speed":30,"course":73,"gpsTime":1615888080,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.781462","lat":"34.776383","speed":20,"course":74,"gpsTime":1615888100,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.781462","lat":"34.776383","speed":8,"course":74,"accStatus":false,"gpsTime":1615888118,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.785387","lat":"34.777235","speed":28,"course":74,"gpsTime":1615888196,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.786856","lat":"34.777563","speed":0,"course":67,"gpsTime":1615888216,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.788111","lat":"34.777874","speed":30,"course":68,"gpsTime":1615888236,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.788111","lat":"34.777874","speed":31,"course":68,"accStatus":false,"gpsTime":1615888240,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.789956","lat":"34.778270","speed":31,"course":74,"gpsTime":1615888256,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.791778","lat":"34.778699","speed":30,"course":75,"gpsTime":1615888276,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.793577","lat":"34.779135","speed":30,"course":74,"gpsTime":1615888296,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.793577","lat":"34.779135","speed":31,"course":74,"accStatus":false,"gpsTime":1615888301,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.805263","lat":"34.778854","speed":29,"course":128,"gpsTime":1615888436,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.806563","lat":"34.777956","speed":16,"course":121,"gpsTime":1615888456,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.807518","lat":"34.777345","speed":27,"course":125,"gpsTime":1615888476,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.807518","lat":"34.777345","speed":31,"course":125,"accStatus":false,"gpsTime":1615888486,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.813555","lat":"34.773655","speed":30,"course":127,"gpsTime":1615888556,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.814981","lat":"34.772695","speed":23,"course":150,"gpsTime":1615888576,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.814524","lat":"34.771520","speed":29,"course":207,"gpsTime":1615888596,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.814524","lat":"34.771520","speed":30,"course":207,"accStatus":false,"gpsTime":1615888608,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.813646","lat":"34.770119","speed":32,"course":209,"gpsTime":1615888616,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.812799","lat":"34.768992","speed":13,"course":209,"gpsTime":1615888636,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.812234","lat":"34.768217","speed":26,"course":211,"gpsTime":1615888658,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.812234","lat":"34.768217","speed":30,"course":211,"accStatus":false,"gpsTime":1615888668,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.811333","lat":"34.766992","speed":24,"course":211,"gpsTime":1615888678,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.811333","lat":"34.766992","speed":23,"course":211,"accStatus":false,"gpsTime":1615888762,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.816891","lat":"34.766293","speed":29,"course":84,"gpsTime":1615888830,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.818050","lat":"34.766252","speed":0,"course":0,"gpsTime":1615888860,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.818050","lat":"34.766252","speed":18,"course":0,"accStatus":false,"gpsTime":1615888883,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.819102","lat":"34.766467","speed":18,"course":70,"gpsTime":1615888888,"positionType":"GPS"},{"code":0,"imei":"866551032598729","lng":"113.819102","lat":"34.766467","speed":10,"course":70,"accStatus":false,"gpsTime":1615889010,"positionType":"GPS"}]
/// msg : "��̨�豸��ʷ�켣"
///
LocusEntity locusEntityFromJson(String str) => LocusEntity.fromMap(json.decode(str));
String locusEntityToJson(LocusEntity data) => json.encode(data.toJson());

class LocusEntity {
  int code;
  List<DataBean> data;
  String msg;

  static LocusEntity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LocusEntity locusEntityBean = LocusEntity();
    locusEntityBean.code = map['code'];
    locusEntityBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => DataBean.fromMap(o))
    );
    locusEntityBean.msg = map['msg'];
    return locusEntityBean;
  }

  Map toJson() => {
    "code": code,
    "data": data,
    "msg": msg,
  };
}

/// code : 0
/// imei : "866551032598729"
/// lng : "113.777579"
/// lat : "34.775200"
/// speed : 0
/// course : 0
/// accStatus : false
/// gpsTime : 1615881206
/// positionType : "GPS"

class DataBean {
  int code;
  String imei;
  String lng;
  String lat;
  int speed;
  int course;
  bool accStatus;
  int gpsTime;
  String positionType;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.code = map['code'];
    dataBean.imei = map['imei'];
    dataBean.lng = map['lng'];
    dataBean.lat = map['lat'];
    dataBean.speed = map['speed'];
    dataBean.course = map['course'];
    dataBean.accStatus = map['accStatus'];
    dataBean.gpsTime = map['gpsTime'];
    dataBean.positionType = map['positionType'];
    return dataBean;
  }

  Map toJson() => {
    "code": code,
    "imei": imei,
    "lng": lng,
    "lat": lat,
    "speed": speed,
    "course": course,
    "accStatus": accStatus,
    "gpsTime": gpsTime,
    "positionType": positionType,
  };
}