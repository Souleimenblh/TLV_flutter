void main() {
  
  List<int> tlv = [1, 4, 1, 2, 3, 4];

  
  var decoded = decodeSimpleTLV(tlv);

  
  print('Decoded TLV: $decoded');
}

Map<String, dynamic> decodeSimpleTLV(List<int> tlv) {
  int tag = tlv[0];
  int length = tlv[1];
  List<int> value = tlv.sublist(2, 2 + length);
  return {'tag': tag, 'length': length, 'value': value};
}
