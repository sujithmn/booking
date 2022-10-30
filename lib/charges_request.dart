class ChargesRequest {
  String origin= '';
  String destn= '';
  String typeofdoc= '';
  String mode='';
  String country='';
  double length =0;
  double height=0;
  double width=0;
  double weight= 0;

  @override
  String toString() {
    return 'origin=$origin&destn=$destn&typeofdoc=$typeofdoc&weight=$weight&mode=$mode&height=$height&with=$width';
  }
}