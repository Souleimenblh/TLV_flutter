void main() {
  
  int tag = 1;
  int length = 4;
  List<int> value = [1, 2, 3, 4];

  
  List<int> tlv = encodeSimpleTLV(tag, length, value);

  
  print('Encoded TLV: $tlv');
}

List<int> encodeSimpleTLV(int tag, int length, List<int> value) {
  List<int> tlv = [];
  tlv.add(tag);
  tlv.add(length);
  tlv.addAll(value);
  return tlv;
}