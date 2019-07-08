
class Constanst{
  static const String imgCardLimaPass = "asset/limapass.jpg";

  static const String dbname = "limapassdb";

  static const List<String> tipoTarjetas = ["Lima Pass",
                                            "Lima Pass Universitaria",
                                            "Lima Pass Escolar",
                                            "Metropolitano",
                                            "Metropolitano Universitaria",
                                            "Metropolitano Escolar",
                                            "Tren Electrico",
                                            "Tren Electrico Universitaria",
                                            "Tren Electrico Escolar",
                                            "Otros"];
  static const Map<String,String> tarjetaImgen = {"Lima Pass":"asset/limapass.jpg",
                                                  "Lima Pass Universitaria":"asset/limapassu.jpg",
                                                  "Lima Pass Escolar":"asset/limapasse.jpg",
                                                  "Metropolitano" : "asset/metropolitano.jpg",
                                                  "Metropolitano Universitaria":"asset/metropolitanou.jpg",
                                                  "Metropolitano Escolar":"asset/metropolitanoe.jpg",
                                                  "Tren Electrico":"asset/tren.jpg",
                                                  "Tren Electrico Universitaria":"asset/trenu.jpg",
                                                  "Tren Electrico Escolar":"asset/trenu.jpg",
                                                  "Otros":"asset/otro.jpg"};
  static const Map<String,List<double>> saldos = {"Lima Pass" : [2.5,1.7,1.0],
                                                  "Lima Pass Universitaria": [0.85,1.2,0.5],
                                                  "Lima Pass Escolar" : [0.85,1.2,0.5],
                                                  "Metropolitano" : [2.5,1.7,1.0],
                                                  "Metropolitano Universitaria" : [0.85,1.2,0.5],
                                                  "Metropolitano Escolar" : [0.85,1.2,0.5],
                                                  "Tren Electrico" : [1.5],
                                                  "Tren Electrico Universitaria": [0.75],
                                                  "Tren Electrico Escolar" : [0.75],
                                                  "Otros" : [2.5,1.7,1.0]
                                                };
  
  static const Map<int,String> diasDeSemana = { 1 : "L",
                                                2 : "M" ,
                                                3 : "X",
                                                4 : "J",
                                                5 : "V",
                                                6 : "S",
                                                7 : "D" 
                                                };
}