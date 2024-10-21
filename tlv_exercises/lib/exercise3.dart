void main() {
  
  List<Map<String, dynamic>> fields = [
    {'tag': 1, 'length': 4, 'value': [1, 2, 3, 4]},
    {'tag': 2, 'length': 2, 'value': [5, 6]},
  ];

  
  List<int> encoded = encodeSequenceTLV(fields);
  print('Encoded Sequence TLV: $encoded');

  
  List<Map<String, dynamic>> decoded = decodeSequenceTLV(encoded);
  print('Decoded Sequence TLV: $decoded');
}

List<int> encodeSequenceTLV(List<Map<String, dynamic>> fields) {
  List<int> tlv = [];
  for (var field in fields) {
    tlv.add(field['tag']);
    tlv.add(field['length']);
    tlv.addAll(field['value']);
  }
  return tlv;
}

List<Map<String, dynamic>> decodeSequenceTLV(List<int> tlv) {
  List<Map<String, dynamic>> fields = [];
  int index = 0;
  while (index < tlv.length) {
    int tag = tlv[index];
    int length = tlv[index + 1];
    List<int> value = tlv.sublist(index + 2, index + 2 + length);
    fields.add({'tag': tag, 'length': length, 'value': value});
    index += 2 + length;
  }
  return fields;
}
