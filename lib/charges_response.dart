class ChargesResponse{
     ChargesResponse({required this.std, required this.pro,required this.prc});
     final String  std;
     final String  pro;
     final String  prc;

     factory ChargesResponse.fromJson(Map<String, dynamic> data) {
          final  std = data['STD'] as String;
          final  pro = data['PRO'] as String;
          final  prc = data['PRC'] as String;
          return ChargesResponse(std: std, pro: pro, prc: prc);
     }
     String toString() {
          return 'std:$std,pro:$pro,prc:$prc';
     }
}