class ChargesRequest {
  String origin= 'blr';
  String destn= 'blr';
  String typeofdoc= '';
  String weight= '.1';
  String mode='';
  @override
  String toString() {
    return 'origin=$origin&destn=$destn&typeofdoc=$typeofdoc&weight=$weight&mode=$mode';
  }
}