class AddressForm {
  late int id;
  late int cep;
  late String addressType;
  late String addressName;
  late String state;
  late String district;
  late String lat;
  late String lng;
  late String city;
  late String cityIbge;
  late String ddd;
  late String number;
  late String complement;

  AddressForm(this.id, this.cep, this.addressType, this.addressName, this.state,
      this.district, this.lat, this.lng, this.city, this.cityIbge, this.ddd,
      this.number, this.complement);

  AddressForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cep = json['cep'];
    addressType = json['address_type'] ?? '';
    addressName = json['address_name'] ?? '';
    state = json['state'] ?? '';
    district = json['district'] ?? '';
    lat = json['lat'] ?? '';
    lng = json['lng'] ?? '';
    city = json['city'] ?? '';
    cityIbge = json['city_ibge'] ?? '';
    ddd = json['ddd'];
    number = json['number'] ?? '';
    complement = json['complement'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cep'] = cep;
    data['address_type'] = addressType;
    data['address_name'] = addressName;
    data['state'] = state;
    data['district'] = district;
    data['lat'] = lat;
    data['lng'] = lng;
    data['city'] = city;
    data['city_ibge'] = cityIbge;
    data['ddd'] = ddd;
    data['number'] = number;
    data['complement'] = complement;
    return data;
  }
}