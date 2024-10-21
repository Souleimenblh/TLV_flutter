class TLV {
  final int type;
  int length;
  String value;

  TLV(this.type, this.value) : length = value.length;

  String encode() {
    return '$type:$length:$value';
  }

  static TLV decode(String encoded) {
    var parts = encoded.split(':');
    if (parts.length < 3) {
      throw FormatException('Invalid TLV format');
    }
    int type = int.parse(parts[0]);
    int.parse(parts[1]);
    String value = parts.sublist(2).join(':');
    return TLV(type, value);
  }
}

class TLVSequence {
  final List<TLV> tlvs;

  TLVSequence(this.tlvs);

  String encode() {
    return tlvs.map((tlv) => tlv.encode()).join('|');
  }

  static List<TLV> decode(String encoded) {
    return encoded.split('|').map((tlvStr) => TLV.decode(tlvStr)).toList();
  }
}

class CompositeTLV extends TLV {
  final List<TLV> subTLVs;

  CompositeTLV(int type, this.subTLVs) : super(type, '') {
    value = TLVSequence(subTLVs).encode();
    length = value.length;
  }

  @override
  String encode() {
    return '$type:$length:${TLVSequence(subTLVs).encode()}';
  }

  static CompositeTLV decode(String encoded) {
    var parts = encoded.split(':');
    if (parts.length < 3) {
      throw FormatException('Invalid Composite TLV format');
    }
    int type = int.parse(parts[0]);
    int.parse(parts[1]);
    String value = parts.sublist(2).join(':'); 
    List<TLV> subTLVs = TLVSequence.decode(value);
    return CompositeTLV(type, subTLVs);
  }
}

void main() {
  CompositeTLV compositeTLV = CompositeTLV(3, [
    TLV(1, "Hello"),
    TLV(2, "World")
  ]);
  

  String encodedComposite = compositeTLV.encode();
  print("Encoded Composite TLV: $encodedComposite");

  CompositeTLV decodedComposite = CompositeTLV.decode(encodedComposite);
  print("Decoded Composite TLV: ${decodedComposite.encode()}");
}