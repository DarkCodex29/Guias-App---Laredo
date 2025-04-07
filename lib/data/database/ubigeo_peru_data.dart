import 'package:app_guias/models/ubigeo.dart';

class UbigeoPeruData {
  static List<Departamento> getDepartamentos() {
    return [
      Departamento(codigo: '01', nombre: 'AMAZONAS'),
      Departamento(codigo: '02', nombre: 'ANCASH'),
      Departamento(codigo: '03', nombre: 'APURIMAC'),
      Departamento(codigo: '04', nombre: 'AREQUIPA'),
      Departamento(codigo: '05', nombre: 'AYACUCHO'),
      Departamento(codigo: '06', nombre: 'CAJAMARCA'),
      Departamento(codigo: '07', nombre: 'CALLAO'),
      Departamento(codigo: '08', nombre: 'CUSCO'),
      Departamento(codigo: '09', nombre: 'HUANCAVELICA'),
      Departamento(codigo: '10', nombre: 'HUANUCO'),
      Departamento(codigo: '11', nombre: 'ICA'),
      Departamento(codigo: '12', nombre: 'JUNIN'),
      Departamento(codigo: '13', nombre: 'LA LIBERTAD'),
      Departamento(codigo: '14', nombre: 'LAMBAYEQUE'),
      Departamento(codigo: '15', nombre: 'LIMA'),
      Departamento(codigo: '16', nombre: 'LORETO'),
      Departamento(codigo: '17', nombre: 'MADRE DE DIOS'),
      Departamento(codigo: '18', nombre: 'MOQUEGUA'),
      Departamento(codigo: '19', nombre: 'PASCO'),
      Departamento(codigo: '20', nombre: 'PIURA'),
      Departamento(codigo: '21', nombre: 'PUNO'),
      Departamento(codigo: '22', nombre: 'SAN MARTIN'),
      Departamento(codigo: '23', nombre: 'TACNA'),
      Departamento(codigo: '24', nombre: 'TUMBES'),
      Departamento(codigo: '25', nombre: 'UCAYALI')
    ];
  }

  static List<Provincia> getProvincias() {
    return [
      Provincia(
          codigo: '0101', nombre: 'CHACHAPOYAS', codigoDepartamento: '01'),
      Provincia(codigo: '0102', nombre: 'BAGUA', codigoDepartamento: '01'),
      Provincia(codigo: '0103', nombre: 'BONGARA', codigoDepartamento: '01'),
      Provincia(
          codigo: '0104', nombre: 'CONDORCANQUI', codigoDepartamento: '01'),
      Provincia(codigo: '0105', nombre: 'LUYA', codigoDepartamento: '01'),
      Provincia(
          codigo: '0106',
          nombre: 'RODRIGUEZ DE MENDOZA',
          codigoDepartamento: '01'),
      Provincia(codigo: '0107', nombre: 'UTCUBAMBA', codigoDepartamento: '01'),
      Provincia(codigo: '0201', nombre: 'HUARAZ', codigoDepartamento: '02'),
      Provincia(codigo: '0202', nombre: 'AIJA', codigoDepartamento: '02'),
      Provincia(
          codigo: '0203', nombre: 'ANTONIO RAYMONDI', codigoDepartamento: '02'),
      Provincia(codigo: '0204', nombre: 'ASUNCION', codigoDepartamento: '02'),
      Provincia(codigo: '0205', nombre: 'BOLOGNESI', codigoDepartamento: '02'),
      Provincia(codigo: '0206', nombre: 'CARHUAZ', codigoDepartamento: '02'),
      Provincia(
          codigo: '0207',
          nombre: 'CARLOS FERMIN FITZCARRALD',
          codigoDepartamento: '02'),
      Provincia(codigo: '0208', nombre: 'CASMA', codigoDepartamento: '02'),
      Provincia(codigo: '0209', nombre: 'CORONGO', codigoDepartamento: '02'),
      Provincia(codigo: '0210', nombre: 'HUARI', codigoDepartamento: '02'),
      Provincia(codigo: '0211', nombre: 'HUARMEY', codigoDepartamento: '02'),
      Provincia(codigo: '0212', nombre: 'HUAYLAS', codigoDepartamento: '02'),
      Provincia(
          codigo: '0213',
          nombre: 'MARISCAL LUZURIAGA',
          codigoDepartamento: '02'),
      Provincia(codigo: '0214', nombre: 'OCROS', codigoDepartamento: '02'),
      Provincia(codigo: '0215', nombre: 'PALLASCA', codigoDepartamento: '02'),
      Provincia(codigo: '0216', nombre: 'POMABAMBA', codigoDepartamento: '02'),
      Provincia(codigo: '0217', nombre: 'RECUAY', codigoDepartamento: '02'),
      Provincia(codigo: '0218', nombre: 'SANTA', codigoDepartamento: '02'),
      Provincia(codigo: '0219', nombre: 'SIHUAS', codigoDepartamento: '02'),
      Provincia(codigo: '0220', nombre: 'YUNGAY', codigoDepartamento: '02'),
      Provincia(codigo: '0301', nombre: 'ABANCAY', codigoDepartamento: '03'),
      Provincia(
          codigo: '0302', nombre: 'ANDAHUAYLAS', codigoDepartamento: '03'),
      Provincia(codigo: '0303', nombre: 'ANTABAMBA', codigoDepartamento: '03'),
      Provincia(codigo: '0304', nombre: 'AYMARAES', codigoDepartamento: '03'),
      Provincia(codigo: '0305', nombre: 'COTABAMBAS', codigoDepartamento: '03'),
      Provincia(codigo: '0306', nombre: 'CHINCHEROS', codigoDepartamento: '03'),
      Provincia(codigo: '0307', nombre: 'GRAU', codigoDepartamento: '03'),
      Provincia(codigo: '0401', nombre: 'AREQUIPA', codigoDepartamento: '04'),
      Provincia(codigo: '0402', nombre: 'CAMANA', codigoDepartamento: '04'),
      Provincia(codigo: '0403', nombre: 'CARAVELI', codigoDepartamento: '04'),
      Provincia(codigo: '0404', nombre: 'CASTILLA', codigoDepartamento: '04'),
      Provincia(codigo: '0405', nombre: 'CAYLLOMA', codigoDepartamento: '04'),
      Provincia(codigo: '0406', nombre: 'CONDESUYOS', codigoDepartamento: '04'),
      Provincia(codigo: '0407', nombre: 'ISLAY', codigoDepartamento: '04'),
      Provincia(codigo: '0408', nombre: 'LA UNION', codigoDepartamento: '04'),
      Provincia(codigo: '0501', nombre: 'HUAMANGA', codigoDepartamento: '05'),
      Provincia(codigo: '0502', nombre: 'CANGALLO', codigoDepartamento: '05'),
      Provincia(
          codigo: '0503', nombre: 'HUANCA SANCOS', codigoDepartamento: '05'),
      Provincia(codigo: '0504', nombre: 'HUANTA', codigoDepartamento: '05'),
      Provincia(codigo: '0505', nombre: 'LA MAR', codigoDepartamento: '05'),
      Provincia(codigo: '0506', nombre: 'LUCANAS', codigoDepartamento: '05'),
      Provincia(
          codigo: '0507', nombre: 'PARINACOCHAS', codigoDepartamento: '05'),
      Provincia(
          codigo: '0508',
          nombre: 'PAUCAR DEL SARA SARA',
          codigoDepartamento: '05'),
      Provincia(codigo: '0509', nombre: 'SUCRE', codigoDepartamento: '05'),
      Provincia(
          codigo: '0510', nombre: 'VICTOR FAJARDO', codigoDepartamento: '05'),
      Provincia(
          codigo: '0511', nombre: 'VILCAS HUAMAN', codigoDepartamento: '05'),
      Provincia(codigo: '0601', nombre: 'CAJAMARCA', codigoDepartamento: '06'),
      Provincia(codigo: '0602', nombre: 'CAJABAMBA', codigoDepartamento: '06'),
      Provincia(codigo: '0603', nombre: 'CELENDIN', codigoDepartamento: '06'),
      Provincia(codigo: '0604', nombre: 'CHOTA', codigoDepartamento: '06'),
      Provincia(codigo: '0605', nombre: 'CONTUMAZA', codigoDepartamento: '06'),
      Provincia(codigo: '0606', nombre: 'CUTERVO', codigoDepartamento: '06'),
      Provincia(codigo: '0607', nombre: 'HUALGAYOC', codigoDepartamento: '06'),
      Provincia(codigo: '0608', nombre: 'JAEN', codigoDepartamento: '06'),
      Provincia(
          codigo: '0609', nombre: 'SAN IGNACIO', codigoDepartamento: '06'),
      Provincia(codigo: '0610', nombre: 'SAN MARCOS', codigoDepartamento: '06'),
      Provincia(codigo: '0611', nombre: 'SAN MIGUEL', codigoDepartamento: '06'),
      Provincia(codigo: '0612', nombre: 'SAN PABLO', codigoDepartamento: '06'),
      Provincia(codigo: '0613', nombre: 'SANTA CRUZ', codigoDepartamento: '06'),
      Provincia(codigo: '0701', nombre: 'CALLAO', codigoDepartamento: '07'),
      Provincia(codigo: '0801', nombre: 'CUSCO', codigoDepartamento: '08'),
      Provincia(codigo: '0802', nombre: 'ACOMAYO', codigoDepartamento: '08'),
      Provincia(codigo: '0803', nombre: 'ANTA', codigoDepartamento: '08'),
      Provincia(codigo: '0804', nombre: 'CALCA', codigoDepartamento: '08'),
      Provincia(codigo: '0805', nombre: 'CANAS', codigoDepartamento: '08'),
      Provincia(codigo: '0806', nombre: 'CANCHIS', codigoDepartamento: '08'),
      Provincia(
          codigo: '0807', nombre: 'CHUMBIVILCAS', codigoDepartamento: '08'),
      Provincia(codigo: '0808', nombre: 'ESPINAR', codigoDepartamento: '08'),
      Provincia(
          codigo: '0809', nombre: 'LA CONVENCION', codigoDepartamento: '08'),
      Provincia(codigo: '0810', nombre: 'PARURO', codigoDepartamento: '08'),
      Provincia(
          codigo: '0811', nombre: 'PAUCARTAMBO', codigoDepartamento: '08'),
      Provincia(
          codigo: '0812', nombre: 'QUISPICANCHI', codigoDepartamento: '08'),
      Provincia(codigo: '0813', nombre: 'URUBAMBA', codigoDepartamento: '08'),
      Provincia(
          codigo: '0901', nombre: 'HUANCAVELICA', codigoDepartamento: '09'),
      Provincia(codigo: '0902', nombre: 'ACOBAMBA', codigoDepartamento: '09'),
      Provincia(codigo: '0903', nombre: 'ANGARAES', codigoDepartamento: '09'),
      Provincia(
          codigo: '0904', nombre: 'CASTROVIRREYNA', codigoDepartamento: '09'),
      Provincia(codigo: '0905', nombre: 'CHURCAMPA', codigoDepartamento: '09'),
      Provincia(codigo: '0906', nombre: 'HUAYTARA', codigoDepartamento: '09'),
      Provincia(codigo: '0907', nombre: 'TAYACAJA', codigoDepartamento: '09'),
      Provincia(codigo: '1001', nombre: 'HUANUCO', codigoDepartamento: '10'),
      Provincia(codigo: '1002', nombre: 'AMBO', codigoDepartamento: '10'),
      Provincia(
          codigo: '1003', nombre: 'DOS DE MAYO', codigoDepartamento: '10'),
      Provincia(
          codigo: '1004', nombre: 'HUACAYBAMBA', codigoDepartamento: '10'),
      Provincia(codigo: '1005', nombre: 'HUAMALIES', codigoDepartamento: '10'),
      Provincia(
          codigo: '1006', nombre: 'LEONCIO PRADO', codigoDepartamento: '10'),
      Provincia(codigo: '1007', nombre: 'MARAÑON', codigoDepartamento: '10'),
      Provincia(codigo: '1008', nombre: 'PACHITEA', codigoDepartamento: '10'),
      Provincia(
          codigo: '1009', nombre: 'PUERTO INCA', codigoDepartamento: '10'),
      Provincia(codigo: '1010', nombre: 'LAURICOCHA', codigoDepartamento: '10'),
      Provincia(codigo: '1011', nombre: 'YAROWILCA', codigoDepartamento: '10'),
      Provincia(codigo: '1101', nombre: 'ICA', codigoDepartamento: '11'),
      Provincia(codigo: '1102', nombre: 'CHINCHA', codigoDepartamento: '11'),
      Provincia(codigo: '1103', nombre: 'NASCA', codigoDepartamento: '11'),
      Provincia(codigo: '1104', nombre: 'PALPA', codigoDepartamento: '11'),
      Provincia(codigo: '1105', nombre: 'PISCO', codigoDepartamento: '11'),
      Provincia(codigo: '1201', nombre: 'HUANCAYO', codigoDepartamento: '12'),
      Provincia(codigo: '1202', nombre: 'CONCEPCION', codigoDepartamento: '12'),
      Provincia(
          codigo: '1203', nombre: 'CHANCHAMAYO', codigoDepartamento: '12'),
      Provincia(codigo: '1204', nombre: 'JAUJA', codigoDepartamento: '12'),
      Provincia(codigo: '1205', nombre: 'JUNIN', codigoDepartamento: '12'),
      Provincia(codigo: '1206', nombre: 'SATIPO', codigoDepartamento: '12'),
      Provincia(codigo: '1207', nombre: 'TARMA', codigoDepartamento: '12'),
      Provincia(codigo: '1208', nombre: 'YAULI', codigoDepartamento: '12'),
      Provincia(codigo: '1209', nombre: 'CHUPACA', codigoDepartamento: '12'),
      Provincia(codigo: '1301', nombre: 'TRUJILLO', codigoDepartamento: '13'),
      Provincia(codigo: '1302', nombre: 'ASCOPE', codigoDepartamento: '13'),
      Provincia(codigo: '1303', nombre: 'BOLIVAR', codigoDepartamento: '13'),
      Provincia(codigo: '1304', nombre: 'CHEPEN', codigoDepartamento: '13'),
      Provincia(codigo: '1305', nombre: 'JULCAN', codigoDepartamento: '13'),
      Provincia(codigo: '1306', nombre: 'OTUZCO', codigoDepartamento: '13'),
      Provincia(codigo: '1307', nombre: 'PACASMAYO', codigoDepartamento: '13'),
      Provincia(codigo: '1308', nombre: 'PATAZ', codigoDepartamento: '13'),
      Provincia(
          codigo: '1309', nombre: 'SANCHEZ CARRION', codigoDepartamento: '13'),
      Provincia(
          codigo: '1310',
          nombre: 'SANTIAGO DE CHUCO',
          codigoDepartamento: '13'),
      Provincia(codigo: '1311', nombre: 'GRAN CHIMU', codigoDepartamento: '13'),
      Provincia(codigo: '1312', nombre: 'VIRU', codigoDepartamento: '13'),
      Provincia(codigo: '1401', nombre: 'CHICLAYO', codigoDepartamento: '14'),
      Provincia(codigo: '1402', nombre: 'FERREÑAFE', codigoDepartamento: '14'),
      Provincia(codigo: '1403', nombre: 'LAMBAYEQUE', codigoDepartamento: '14'),
      Provincia(codigo: '1501', nombre: 'LIMA', codigoDepartamento: '15'),
      Provincia(codigo: '1502', nombre: 'BARRANCA', codigoDepartamento: '15'),
      Provincia(codigo: '1503', nombre: 'CAJATAMBO', codigoDepartamento: '15'),
      Provincia(codigo: '1504', nombre: 'CANTA', codigoDepartamento: '15'),
      Provincia(codigo: '1505', nombre: 'CAÑETE', codigoDepartamento: '15'),
      Provincia(codigo: '1506', nombre: 'HUARAL', codigoDepartamento: '15'),
      Provincia(codigo: '1507', nombre: 'HUAROCHIRI', codigoDepartamento: '15'),
      Provincia(codigo: '1508', nombre: 'HUAURA', codigoDepartamento: '15'),
      Provincia(codigo: '1509', nombre: 'OYON', codigoDepartamento: '15'),
      Provincia(codigo: '1510', nombre: 'YAUYOS', codigoDepartamento: '15'),
      Provincia(codigo: '1601', nombre: 'MAYNAS', codigoDepartamento: '16'),
      Provincia(
          codigo: '1602', nombre: 'ALTO AMAZONAS', codigoDepartamento: '16'),
      Provincia(codigo: '1603', nombre: 'LORETO', codigoDepartamento: '16'),
      Provincia(
          codigo: '1604',
          nombre: 'MARISCAL RAMON CASTILLA',
          codigoDepartamento: '16'),
      Provincia(codigo: '1605', nombre: 'REQUENA', codigoDepartamento: '16'),
      Provincia(codigo: '1606', nombre: 'UCAYALI', codigoDepartamento: '16'),
      Provincia(
          codigo: '1607',
          nombre: 'DATEM DEL MARAÑON',
          codigoDepartamento: '16'),
      Provincia(codigo: '1608', nombre: 'PUTUMAYO', codigoDepartamento: '16'),
      Provincia(codigo: '1701', nombre: 'TAMBOPATA', codigoDepartamento: '17'),
      Provincia(codigo: '1702', nombre: 'MANU', codigoDepartamento: '17'),
      Provincia(codigo: '1703', nombre: 'TAHUAMANU', codigoDepartamento: '17'),
      Provincia(
          codigo: '1801', nombre: 'MARISCAL NIETO', codigoDepartamento: '18'),
      Provincia(
          codigo: '1802',
          nombre: 'GENERAL SANCHEZ CERRO',
          codigoDepartamento: '18'),
      Provincia(codigo: '1803', nombre: 'ILO', codigoDepartamento: '18'),
      Provincia(codigo: '1901', nombre: 'PASCO', codigoDepartamento: '19'),
      Provincia(
          codigo: '1902',
          nombre: 'DANIEL ALCIDES CARRION',
          codigoDepartamento: '19'),
      Provincia(codigo: '1903', nombre: 'OXAPAMPA', codigoDepartamento: '19'),
      Provincia(codigo: '2001', nombre: 'PIURA', codigoDepartamento: '20'),
      Provincia(codigo: '2002', nombre: 'AYABACA', codigoDepartamento: '20'),
      Provincia(
          codigo: '2003', nombre: 'HUANCABAMBA', codigoDepartamento: '20'),
      Provincia(codigo: '2004', nombre: 'MORROPON', codigoDepartamento: '20'),
      Provincia(codigo: '2005', nombre: 'PAITA', codigoDepartamento: '20'),
      Provincia(codigo: '2006', nombre: 'SULLANA', codigoDepartamento: '20'),
      Provincia(codigo: '2007', nombre: 'TALARA', codigoDepartamento: '20'),
      Provincia(codigo: '2008', nombre: 'SECHURA', codigoDepartamento: '20'),
      Provincia(codigo: '2101', nombre: 'PUNO', codigoDepartamento: '21'),
      Provincia(codigo: '2102', nombre: 'AZANGARO', codigoDepartamento: '21'),
      Provincia(codigo: '2103', nombre: 'CARABAYA', codigoDepartamento: '21'),
      Provincia(codigo: '2104', nombre: 'CHUCUITO', codigoDepartamento: '21'),
      Provincia(codigo: '2105', nombre: 'EL COLLAO', codigoDepartamento: '21'),
      Provincia(codigo: '2106', nombre: 'HUANCANE', codigoDepartamento: '21'),
      Provincia(codigo: '2107', nombre: 'LAMPA', codigoDepartamento: '21'),
      Provincia(codigo: '2108', nombre: 'MELGAR', codigoDepartamento: '21'),
      Provincia(codigo: '2109', nombre: 'MOHO', codigoDepartamento: '21'),
      Provincia(
          codigo: '2110',
          nombre: 'SAN ANTONIO DE PUTINA',
          codigoDepartamento: '21'),
      Provincia(codigo: '2111', nombre: 'SAN ROMAN', codigoDepartamento: '21'),
      Provincia(codigo: '2112', nombre: 'SANDIA', codigoDepartamento: '21'),
      Provincia(codigo: '2113', nombre: 'YUNGUYO', codigoDepartamento: '21'),
      Provincia(codigo: '2201', nombre: 'MOYOBAMBA', codigoDepartamento: '22'),
      Provincia(codigo: '2202', nombre: 'BELLAVISTA', codigoDepartamento: '22'),
      Provincia(codigo: '2203', nombre: 'EL DORADO', codigoDepartamento: '22'),
      Provincia(codigo: '2204', nombre: 'HUALLAGA', codigoDepartamento: '22'),
      Provincia(codigo: '2205', nombre: 'LAMAS', codigoDepartamento: '22'),
      Provincia(
          codigo: '2206', nombre: 'MARISCAL CACERES', codigoDepartamento: '22'),
      Provincia(codigo: '2207', nombre: 'PICOTA', codigoDepartamento: '22'),
      Provincia(codigo: '2208', nombre: 'RIOJA', codigoDepartamento: '22'),
      Provincia(codigo: '2209', nombre: 'SAN MARTIN', codigoDepartamento: '22'),
      Provincia(codigo: '2210', nombre: 'TOCACHE', codigoDepartamento: '22'),
      Provincia(codigo: '2301', nombre: 'TACNA', codigoDepartamento: '23'),
      Provincia(codigo: '2302', nombre: 'CANDARAVE', codigoDepartamento: '23'),
      Provincia(
          codigo: '2303', nombre: 'JORGE BASADRE', codigoDepartamento: '23'),
      Provincia(codigo: '2304', nombre: 'TARATA', codigoDepartamento: '23'),
      Provincia(codigo: '2401', nombre: 'TUMBES', codigoDepartamento: '24'),
      Provincia(
          codigo: '2402',
          nombre: 'CONTRALMIRANTE VILLAR',
          codigoDepartamento: '24'),
      Provincia(codigo: '2403', nombre: 'ZARUMILLA', codigoDepartamento: '24'),
      Provincia(
          codigo: '2501', nombre: 'CORONEL PORTILLO', codigoDepartamento: '25'),
      Provincia(codigo: '2502', nombre: 'ATALAYA', codigoDepartamento: '25'),
      Provincia(codigo: '2503', nombre: 'PADRE ABAD', codigoDepartamento: '25'),
      Provincia(codigo: '2504', nombre: 'PURUS', codigoDepartamento: '25')
    ];
  }

  static List<Distrito> getDistritos() {
    return [
      Distrito(
          codigo: '010101',
          nombre: 'CHACHAPOYAS',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010102',
          nombre: 'ASUNCION',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010103',
          nombre: 'BALSAS',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010104',
          nombre: 'CHETO',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010105',
          nombre: 'CHILIQUIN',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010106',
          nombre: 'CHUQUIBAMBA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010107',
          nombre: 'GRANADA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010108',
          nombre: 'HUANCAS',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010109',
          nombre: 'LA JALCA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010110',
          nombre: 'LEIMEBAMBA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010111',
          nombre: 'LEVANTO',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010112',
          nombre: 'MAGDALENA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010113',
          nombre: 'MARISCAL CASTILLA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010114',
          nombre: 'MOLINOPAMPA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010115',
          nombre: 'MONTEVIDEO',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010116',
          nombre: 'OLLEROS',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010117',
          nombre: 'QUINJALCA',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010118',
          nombre: 'SAN FRANCISCO DE DAGUAS',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010119',
          nombre: 'SAN ISIDRO DE MAINO',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010120',
          nombre: 'SOLOCO',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010121',
          nombre: 'SONCHE',
          codigoProvincia: '0101',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010201',
          nombre: 'BAGUA',
          codigoProvincia: '0102',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010202',
          nombre: 'ARAMANGO',
          codigoProvincia: '0102',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010203',
          nombre: 'COPALLIN',
          codigoProvincia: '0102',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010204',
          nombre: 'EL PARCO',
          codigoProvincia: '0102',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010205',
          nombre: 'IMAZA',
          codigoProvincia: '0102',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010206',
          nombre: 'LA PECA',
          codigoProvincia: '0102',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010301',
          nombre: 'JUMBILLA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010302',
          nombre: 'CHISQUILLA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010303',
          nombre: 'CHURUJA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010304',
          nombre: 'COROSHA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010305',
          nombre: 'CUISPES',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010306',
          nombre: 'FLORIDA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010307',
          nombre: 'JAZAN',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010308',
          nombre: 'RECTA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010309',
          nombre: 'SAN CARLOS',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010310',
          nombre: 'SHIPASBAMBA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010311',
          nombre: 'VALERA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010312',
          nombre: 'YAMBRASBAMBA',
          codigoProvincia: '0103',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010401',
          nombre: 'NIEVA',
          codigoProvincia: '0104',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010402',
          nombre: 'EL CENEPA',
          codigoProvincia: '0104',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010403',
          nombre: 'RIO SANTIAGO',
          codigoProvincia: '0104',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010501',
          nombre: 'LAMUD',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010502',
          nombre: 'CAMPORREDONDO',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010503',
          nombre: 'COCABAMBA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010504',
          nombre: 'COLCAMAR',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010505',
          nombre: 'CONILA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010506',
          nombre: 'INGUILPATA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010507',
          nombre: 'LONGUITA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010508',
          nombre: 'LONYA CHICO',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010509',
          nombre: 'LUYA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010510',
          nombre: 'LUYA VIEJO',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010511',
          nombre: 'MARIA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010512',
          nombre: 'OCALLI',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010513',
          nombre: 'OCUMAL',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010514',
          nombre: 'PISUQUIA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010515',
          nombre: 'PROVIDENCIA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010516',
          nombre: 'SAN CRISTOBAL',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010517',
          nombre: 'SAN FRANCISCO DEL YESO',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010518',
          nombre: 'SAN JERONIMO',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010519',
          nombre: 'SAN JUAN DE LOPECANCHA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010520',
          nombre: 'SANTA CATALINA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010521',
          nombre: 'SANTO TOMAS',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010522',
          nombre: 'TINGO',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010523',
          nombre: 'TRITA',
          codigoProvincia: '0105',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010601',
          nombre: 'SAN NICOLAS',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010602',
          nombre: 'CHIRIMOTO',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010603',
          nombre: 'COCHAMAL',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010604',
          nombre: 'HUAMBO',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010605',
          nombre: 'LIMABAMBA',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010606',
          nombre: 'LONGAR',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010607',
          nombre: 'MARISCAL BENAVIDES',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010608',
          nombre: 'MILPUC',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010609',
          nombre: 'OMIA',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010610',
          nombre: 'SANTA ROSA',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010611',
          nombre: 'TOTORA',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010612',
          nombre: 'VISTA ALEGRE',
          codigoProvincia: '0106',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010701',
          nombre: 'BAGUA GRANDE',
          codigoProvincia: '0107',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010702',
          nombre: 'CAJARURO',
          codigoProvincia: '0107',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010703',
          nombre: 'CUMBA',
          codigoProvincia: '0107',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010704',
          nombre: 'EL MILAGRO',
          codigoProvincia: '0107',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010705',
          nombre: 'JAMALCA',
          codigoProvincia: '0107',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010706',
          nombre: 'LONYA GRANDE',
          codigoProvincia: '0107',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '010707',
          nombre: 'YAMON',
          codigoProvincia: '0107',
          codigoDepartamento: '01'),
      Distrito(
          codigo: '020101',
          nombre: 'HUARAZ',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020102',
          nombre: 'COCHABAMBA',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020103',
          nombre: 'COLCABAMBA',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020104',
          nombre: 'HUANCHAY',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020105',
          nombre: 'INDEPENDENCIA',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020106',
          nombre: 'JANGAS',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020107',
          nombre: 'LA LIBERTAD',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020108',
          nombre: 'OLLEROS',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020109',
          nombre: 'PAMPAS GRANDE',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020110',
          nombre: 'PARIACOTO',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020111',
          nombre: 'PIRA',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020112',
          nombre: 'TARICA',
          codigoProvincia: '0201',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020201',
          nombre: 'AIJA',
          codigoProvincia: '0202',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020202',
          nombre: 'CORIS',
          codigoProvincia: '0202',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020203',
          nombre: 'HUACLLAN',
          codigoProvincia: '0202',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020204',
          nombre: 'LA MERCED',
          codigoProvincia: '0202',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020205',
          nombre: 'SUCCHA',
          codigoProvincia: '0202',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020301',
          nombre: 'LLAMELLIN',
          codigoProvincia: '0203',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020302',
          nombre: 'ACZO',
          codigoProvincia: '0203',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020303',
          nombre: 'CHACCHO',
          codigoProvincia: '0203',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020304',
          nombre: 'CHINGAS',
          codigoProvincia: '0203',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020305',
          nombre: 'MIRGAS',
          codigoProvincia: '0203',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020306',
          nombre: 'SAN JUAN DE RONTOY',
          codigoProvincia: '0203',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020401',
          nombre: 'CHACAS',
          codigoProvincia: '0204',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020402',
          nombre: 'ACOCHACA',
          codigoProvincia: '0204',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020501',
          nombre: 'CHIQUIAN',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020502',
          nombre: 'ABELARDO PARDO LEZAMETA',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020503',
          nombre: 'ANTONIO RAYMONDI',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020504',
          nombre: 'AQUIA',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020505',
          nombre: 'CAJACAY',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020506',
          nombre: 'CANIS',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020507',
          nombre: 'COLQUIOC',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020508',
          nombre: 'HUALLANCA',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020509',
          nombre: 'HUASTA',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020510',
          nombre: 'HUAYLLACAYAN',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020511',
          nombre: 'LA PRIMAVERA',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020512',
          nombre: 'MANGAS',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020513',
          nombre: 'PACLLON',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020514',
          nombre: 'SAN MIGUEL DE CORPANQUI',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020515',
          nombre: 'TICLLOS',
          codigoProvincia: '0205',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020601',
          nombre: 'CARHUAZ',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020602',
          nombre: 'ACOPAMPA',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020603',
          nombre: 'AMASHCA',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020604',
          nombre: 'ANTA',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020605',
          nombre: 'ATAQUERO',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020606',
          nombre: 'MARCARA',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020607',
          nombre: 'PARIAHUANCA',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020608',
          nombre: 'SAN MIGUEL DE ACO',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020609',
          nombre: 'SHILLA',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020610',
          nombre: 'TINCO',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020611',
          nombre: 'YUNGAR',
          codigoProvincia: '0206',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020701',
          nombre: 'SAN LUIS',
          codigoProvincia: '0207',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020702',
          nombre: 'SAN NICOLAS',
          codigoProvincia: '0207',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020703',
          nombre: 'YAUYA',
          codigoProvincia: '0207',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020801',
          nombre: 'CASMA',
          codigoProvincia: '0208',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020802',
          nombre: 'BUENA VISTA ALTA',
          codigoProvincia: '0208',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020803',
          nombre: 'COMANDANTE NOEL',
          codigoProvincia: '0208',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020804',
          nombre: 'YAUTAN',
          codigoProvincia: '0208',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020901',
          nombre: 'CORONGO',
          codigoProvincia: '0209',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020902',
          nombre: 'ACO',
          codigoProvincia: '0209',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020903',
          nombre: 'BAMBAS',
          codigoProvincia: '0209',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020904',
          nombre: 'CUSCA',
          codigoProvincia: '0209',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020905',
          nombre: 'LA PAMPA',
          codigoProvincia: '0209',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020906',
          nombre: 'YANAC',
          codigoProvincia: '0209',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '020907',
          nombre: 'YUPAN',
          codigoProvincia: '0209',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021001',
          nombre: 'HUARI',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021002',
          nombre: 'ANRA',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021003',
          nombre: 'CAJAY',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021004',
          nombre: 'CHAVIN DE HUANTAR',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021005',
          nombre: 'HUACACHI',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021006',
          nombre: 'HUACCHIS',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021007',
          nombre: 'HUACHIS',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021008',
          nombre: 'HUANTAR',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021009',
          nombre: 'MASIN',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021010',
          nombre: 'PAUCAS',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021011',
          nombre: 'PONTO',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021012',
          nombre: 'RAHUAPAMPA',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021013',
          nombre: 'RAPAYAN',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021014',
          nombre: 'SAN MARCOS',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021015',
          nombre: 'SAN PEDRO DE CHANA',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021016',
          nombre: 'UCO',
          codigoProvincia: '0210',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021101',
          nombre: 'HUARMEY',
          codigoProvincia: '0211',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021102',
          nombre: 'COCHAPETI',
          codigoProvincia: '0211',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021103',
          nombre: 'CULEBRAS',
          codigoProvincia: '0211',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021104',
          nombre: 'HUAYAN',
          codigoProvincia: '0211',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021105',
          nombre: 'MALVAS',
          codigoProvincia: '0211',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021201',
          nombre: 'CARAZ',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021202',
          nombre: 'HUALLANCA',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021203',
          nombre: 'HUATA',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021204',
          nombre: 'HUAYLAS',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021205',
          nombre: 'MATO',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021206',
          nombre: 'PAMPAROMAS',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021207',
          nombre: 'PUEBLO LIBRE',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021208',
          nombre: 'SANTA CRUZ',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021209',
          nombre: 'SANTO TORIBIO',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021210',
          nombre: 'YURACMARCA',
          codigoProvincia: '0212',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021301',
          nombre: 'PISCOBAMBA',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021302',
          nombre: 'CASCA',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021303',
          nombre: 'ELEAZAR GUZMAN BARRON',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021304',
          nombre: 'FIDEL OLIVAS ESCUDERO',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021305',
          nombre: 'LLAMA',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021306',
          nombre: 'LLUMPA',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021307',
          nombre: 'LUCMA',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021308',
          nombre: 'MUSGA',
          codigoProvincia: '0213',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021401',
          nombre: 'OCROS',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021402',
          nombre: 'ACAS',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021403',
          nombre: 'CAJAMARQUILLA',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021404',
          nombre: 'CARHUAPAMPA',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021405',
          nombre: 'COCHAS',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021406',
          nombre: 'CONGAS',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021407',
          nombre: 'LLIPA',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021408',
          nombre: 'SAN CRISTOBAL DE RAJAN',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021409',
          nombre: 'SAN PEDRO',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021410',
          nombre: 'SANTIAGO DE CHILCAS',
          codigoProvincia: '0214',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021501',
          nombre: 'CABANA',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021502',
          nombre: 'BOLOGNESI',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021503',
          nombre: 'CONCHUCOS',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021504',
          nombre: 'HUACASCHUQUE',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021505',
          nombre: 'HUANDOVAL',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021506',
          nombre: 'LACABAMBA',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021507',
          nombre: 'LLAPO',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021508',
          nombre: 'PALLASCA',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021509',
          nombre: 'PAMPAS',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021510',
          nombre: 'SANTA ROSA',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021511',
          nombre: 'TAUCA',
          codigoProvincia: '0215',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021601',
          nombre: 'POMABAMBA',
          codigoProvincia: '0216',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021602',
          nombre: 'HUAYLLAN',
          codigoProvincia: '0216',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021603',
          nombre: 'PAROBAMBA',
          codigoProvincia: '0216',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021604',
          nombre: 'QUINUABAMBA',
          codigoProvincia: '0216',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021701',
          nombre: 'RECUAY',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021702',
          nombre: 'CATAC',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021703',
          nombre: 'COTAPARACO',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021704',
          nombre: 'HUAYLLAPAMPA',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021705',
          nombre: 'LLACLLIN',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021706',
          nombre: 'MARCA',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021707',
          nombre: 'PAMPAS CHICO',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021708',
          nombre: 'PARARIN',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021709',
          nombre: 'TAPACOCHA',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021710',
          nombre: 'TICAPAMPA',
          codigoProvincia: '0217',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021801',
          nombre: 'CHIMBOTE',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021802',
          nombre: 'CACERES DEL PERU',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021803',
          nombre: 'COISHCO',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021804',
          nombre: 'MACATE',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021805',
          nombre: 'MORO',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021806',
          nombre: 'NEPEÑA',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021807',
          nombre: 'SAMANCO',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021808',
          nombre: 'SANTA',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021809',
          nombre: 'NUEVO CHIMBOTE',
          codigoProvincia: '0218',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021901',
          nombre: 'SIHUAS',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021902',
          nombre: 'ACOBAMBA',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021903',
          nombre: 'ALFONSO UGARTE',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021904',
          nombre: 'CASHAPAMPA',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021905',
          nombre: 'CHINGALPO',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021906',
          nombre: 'HUAYLLABAMBA',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021907',
          nombre: 'QUICHES',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021908',
          nombre: 'RAGASH',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021909',
          nombre: 'SAN JUAN',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '021910',
          nombre: 'SICSIBAMBA',
          codigoProvincia: '0219',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022001',
          nombre: 'YUNGAY',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022002',
          nombre: 'CASCAPARA',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022003',
          nombre: 'MANCOS',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022004',
          nombre: 'MATACOTO',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022005',
          nombre: 'QUILLO',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022006',
          nombre: 'RANRAHIRCA',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022007',
          nombre: 'SHUPLUY',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '022008',
          nombre: 'YANAMA',
          codigoProvincia: '0220',
          codigoDepartamento: '02'),
      Distrito(
          codigo: '030101',
          nombre: 'ABANCAY',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030102',
          nombre: 'CHACOCHE',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030103',
          nombre: 'CIRCA',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030104',
          nombre: 'CURAHUASI',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030105',
          nombre: 'HUANIPACA',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030106',
          nombre: 'LAMBRAMA',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030107',
          nombre: 'PICHIRHUA',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030108',
          nombre: 'SAN PEDRO DE CACHORA',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030109',
          nombre: 'TAMBURCO',
          codigoProvincia: '0301',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030201',
          nombre: 'ANDAHUAYLAS',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030202',
          nombre: 'ANDARAPA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030203',
          nombre: 'CHIARA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030204',
          nombre: 'HUANCARAMA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030205',
          nombre: 'HUANCARAY',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030206',
          nombre: 'HUAYANA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030207',
          nombre: 'KISHUARA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030208',
          nombre: 'PACOBAMBA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030209',
          nombre: 'PACUCHA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030210',
          nombre: 'PAMPACHIRI',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030211',
          nombre: 'POMACOCHA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030212',
          nombre: 'SAN ANTONIO DE CACHI',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030213',
          nombre: 'SAN JERONIMO',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030214',
          nombre: 'SAN MIGUEL DE CHACCRAMPA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030215',
          nombre: 'SANTA MARIA DE CHICMO',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030216',
          nombre: 'TALAVERA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030217',
          nombre: 'TUMAY HUARACA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030218',
          nombre: 'TURPO',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030219',
          nombre: 'KAQUIABAMBA',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030220',
          nombre: 'JOSE MARIA ARGUEDAS',
          codigoProvincia: '0302',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030301',
          nombre: 'ANTABAMBA',
          codigoProvincia: '0303',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030302',
          nombre: 'EL ORO',
          codigoProvincia: '0303',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030303',
          nombre: 'HUAQUIRCA',
          codigoProvincia: '0303',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030304',
          nombre: 'JUAN ESPINOZA MEDRANO',
          codigoProvincia: '0303',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030305',
          nombre: 'OROPESA',
          codigoProvincia: '0303',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030306',
          nombre: 'PACHACONAS',
          codigoProvincia: '0303',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030307',
          nombre: 'SABAINO',
          codigoProvincia: '0303',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030401',
          nombre: 'CHALHUANCA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030402',
          nombre: 'CAPAYA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030403',
          nombre: 'CARAYBAMBA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030404',
          nombre: 'CHAPIMARCA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030405',
          nombre: 'COLCABAMBA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030406',
          nombre: 'COTARUSE',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030407',
          nombre: 'IHUAYLLO',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030408',
          nombre: 'JUSTO APU SAHUARAURA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030409',
          nombre: 'LUCRE',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030410',
          nombre: 'POCOHUANCA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030411',
          nombre: 'SAN JUAN DE CHACÑA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030412',
          nombre: 'SAÑAYCA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030413',
          nombre: 'SORAYA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030414',
          nombre: 'TAPAIRIHUA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030415',
          nombre: 'TINTAY',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030416',
          nombre: 'TORAYA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030417',
          nombre: 'YANACA',
          codigoProvincia: '0304',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030501',
          nombre: 'TAMBOBAMBA',
          codigoProvincia: '0305',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030502',
          nombre: 'COTABAMBAS',
          codigoProvincia: '0305',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030503',
          nombre: 'COYLLURQUI',
          codigoProvincia: '0305',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030504',
          nombre: 'HAQUIRA',
          codigoProvincia: '0305',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030505',
          nombre: 'MARA',
          codigoProvincia: '0305',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030506',
          nombre: 'CHALLHUAHUACHO',
          codigoProvincia: '0305',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030601',
          nombre: 'CHINCHEROS',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030602',
          nombre: 'ANCO_HUALLO',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030603',
          nombre: 'COCHARCAS',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030604',
          nombre: 'HUACCANA',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030605',
          nombre: 'OCOBAMBA',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030606',
          nombre: 'ONGOY',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030607',
          nombre: 'URANMARCA',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030608',
          nombre: 'RANRACANCHA',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030609',
          nombre: 'ROCCHACC',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030610',
          nombre: 'EL PORVENIR',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030611',
          nombre: 'LOS CHANKAS',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030612',
          nombre: 'AHUAYRO',
          codigoProvincia: '0306',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030701',
          nombre: 'CHUQUIBAMBILLA',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030702',
          nombre: 'CURPAHUASI',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030703',
          nombre: 'GAMARRA',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030704',
          nombre: 'HUAYLLATI',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030705',
          nombre: 'MAMARA',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030706',
          nombre: 'MICAELA BASTIDAS',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030707',
          nombre: 'PATAYPAMPA',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030708',
          nombre: 'PROGRESO',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030709',
          nombre: 'SAN ANTONIO',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030710',
          nombre: 'SANTA ROSA',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030711',
          nombre: 'TURPAY',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030712',
          nombre: 'VILCABAMBA',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030713',
          nombre: 'VIRUNDO',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '030714',
          nombre: 'CURASCO',
          codigoProvincia: '0307',
          codigoDepartamento: '03'),
      Distrito(
          codigo: '040101',
          nombre: 'AREQUIPA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040102',
          nombre: 'ALTO SELVA ALEGRE',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040103',
          nombre: 'CAYMA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040104',
          nombre: 'CERRO COLORADO',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040105',
          nombre: 'CHARACATO',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040106',
          nombre: 'CHIGUATA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040107',
          nombre: 'JACOBO HUNTER',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040108',
          nombre: 'LA JOYA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040109',
          nombre: 'MARIANO MELGAR',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040110',
          nombre: 'MIRAFLORES',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040111',
          nombre: 'MOLLEBAYA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040112',
          nombre: 'PAUCARPATA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040113',
          nombre: 'POCSI',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040114',
          nombre: 'POLOBAYA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040115',
          nombre: 'QUEQUEÑA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040116',
          nombre: 'SABANDIA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040117',
          nombre: 'SACHACA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040118',
          nombre: 'SAN JUAN DE SIGUAS',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040119',
          nombre: 'SAN JUAN DE TARUCANI',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040120',
          nombre: 'SANTA ISABEL DE SIGUAS',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040121',
          nombre: 'SANTA RITA DE SIGUAS',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040122',
          nombre: 'SOCABAYA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040123',
          nombre: 'TIABAYA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040124',
          nombre: 'UCHUMAYO',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040125',
          nombre: 'VITOR',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040126',
          nombre: 'YANAHUARA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040127',
          nombre: 'YARABAMBA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040128',
          nombre: 'YURA',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040129',
          nombre: 'JOSE LUIS BUSTAMANTE Y RIVERO',
          codigoProvincia: '0401',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040201',
          nombre: 'CAMANA',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040202',
          nombre: 'JOSE MARIA QUIMPER',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040203',
          nombre: 'MARIANO NICOLAS VALCARCEL',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040204',
          nombre: 'MARISCAL CACERES',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040205',
          nombre: 'NICOLAS DE PIEROLA',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040206',
          nombre: 'OCOÑA',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040207',
          nombre: 'QUILCA',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040208',
          nombre: 'SAMUEL PASTOR',
          codigoProvincia: '0402',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040301',
          nombre: 'CARAVELI',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040302',
          nombre: 'ACARI',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040303',
          nombre: 'ATICO',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040304',
          nombre: 'ATIQUIPA',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040305',
          nombre: 'BELLA UNION',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040306',
          nombre: 'CAHUACHO',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040307',
          nombre: 'CHALA',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040308',
          nombre: 'CHAPARRA',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040309',
          nombre: 'HUANUHUANU',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040310',
          nombre: 'JAQUI',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040311',
          nombre: 'LOMAS',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040312',
          nombre: 'QUICACHA',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040313',
          nombre: 'YAUCA',
          codigoProvincia: '0403',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040401',
          nombre: 'APLAO',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040402',
          nombre: 'ANDAGUA',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040403',
          nombre: 'AYO',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040404',
          nombre: 'CHACHAS',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040405',
          nombre: 'CHILCAYMARCA',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040406',
          nombre: 'CHOCO',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040407',
          nombre: 'HUANCARQUI',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040408',
          nombre: 'MACHAGUAY',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040409',
          nombre: 'ORCOPAMPA',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040410',
          nombre: 'PAMPACOLCA',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040411',
          nombre: 'TIPAN',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040412',
          nombre: 'UÑON',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040413',
          nombre: 'URACA',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040414',
          nombre: 'VIRACO',
          codigoProvincia: '0404',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040501',
          nombre: 'CHIVAY',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040502',
          nombre: 'ACHOMA',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040503',
          nombre: 'CABANACONDE',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040504',
          nombre: 'CALLALLI',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040505',
          nombre: 'CAYLLOMA',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040506',
          nombre: 'COPORAQUE',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040507',
          nombre: 'HUAMBO',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040508',
          nombre: 'HUANCA',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040509',
          nombre: 'ICHUPAMPA',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040510',
          nombre: 'LARI',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040511',
          nombre: 'LLUTA',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040512',
          nombre: 'MACA',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040513',
          nombre: 'MADRIGAL',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040514',
          nombre: 'SAN ANTONIO DE CHUCA',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040515',
          nombre: 'SIBAYO',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040516',
          nombre: 'TAPAY',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040517',
          nombre: 'TISCO',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040518',
          nombre: 'TUTI',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040519',
          nombre: 'YANQUE',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040520',
          nombre: 'MAJES',
          codigoProvincia: '0405',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040601',
          nombre: 'CHUQUIBAMBA',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040602',
          nombre: 'ANDARAY',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040603',
          nombre: 'CAYARANI',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040604',
          nombre: 'CHICHAS',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040605',
          nombre: 'IRAY',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040606',
          nombre: 'RIO GRANDE',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040607',
          nombre: 'SALAMANCA',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040608',
          nombre: 'YANAQUIHUA',
          codigoProvincia: '0406',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040701',
          nombre: 'MOLLENDO',
          codigoProvincia: '0407',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040702',
          nombre: 'COCACHACRA',
          codigoProvincia: '0407',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040703',
          nombre: 'DEAN VALDIVIA',
          codigoProvincia: '0407',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040704',
          nombre: 'ISLAY',
          codigoProvincia: '0407',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040705',
          nombre: 'MEJIA',
          codigoProvincia: '0407',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040706',
          nombre: 'PUNTA DE BOMBON',
          codigoProvincia: '0407',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040801',
          nombre: 'COTAHUASI',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040802',
          nombre: 'ALCA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040803',
          nombre: 'CHARCANA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040804',
          nombre: 'HUAYNACOTAS',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040805',
          nombre: 'PAMPAMARCA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040806',
          nombre: 'PUYCA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040807',
          nombre: 'QUECHUALLA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040808',
          nombre: 'SAYLA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040809',
          nombre: 'TAURIA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040810',
          nombre: 'TOMEPAMPA',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '040811',
          nombre: 'TORO',
          codigoProvincia: '0408',
          codigoDepartamento: '04'),
      Distrito(
          codigo: '050101',
          nombre: 'AYACUCHO',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050102',
          nombre: 'ACOCRO',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050103',
          nombre: 'ACOS VINCHOS',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050104',
          nombre: 'CARMEN ALTO',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050105',
          nombre: 'CHIARA',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050106',
          nombre: 'OCROS',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050107',
          nombre: 'PACAYCASA',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050108',
          nombre: 'QUINUA',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050109',
          nombre: 'SAN JOSE DE TICLLAS',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050110',
          nombre: 'SAN JUAN BAUTISTA',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050111',
          nombre: 'SANTIAGO DE PISCHA',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050112',
          nombre: 'SOCOS',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050113',
          nombre: 'TAMBILLO',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050114',
          nombre: 'VINCHOS',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050115',
          nombre: 'JESUS NAZARENO',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050116',
          nombre: 'ANDRES AVELINO CACERES DORREGARAY',
          codigoProvincia: '0501',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050201',
          nombre: 'CANGALLO',
          codigoProvincia: '0502',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050202',
          nombre: 'CHUSCHI',
          codigoProvincia: '0502',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050203',
          nombre: 'LOS MOROCHUCOS',
          codigoProvincia: '0502',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050204',
          nombre: 'MARIA PARADO DE BELLIDO',
          codigoProvincia: '0502',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050205',
          nombre: 'PARAS',
          codigoProvincia: '0502',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050206',
          nombre: 'TOTOS',
          codigoProvincia: '0502',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050301',
          nombre: 'SANCOS',
          codigoProvincia: '0503',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050302',
          nombre: 'CARAPO',
          codigoProvincia: '0503',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050303',
          nombre: 'SACSAMARCA',
          codigoProvincia: '0503',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050304',
          nombre: 'SANTIAGO DE LUCANAMARCA',
          codigoProvincia: '0503',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050401',
          nombre: 'HUANTA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050402',
          nombre: 'AYAHUANCO',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050403',
          nombre: 'HUAMANGUILLA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050404',
          nombre: 'IGUAIN',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050405',
          nombre: 'LURICOCHA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050406',
          nombre: 'SANTILLANA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050407',
          nombre: 'SIVIA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050408',
          nombre: 'LLOCHEGUA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050409',
          nombre: 'CANAYRE',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050410',
          nombre: 'UCHURACCAY',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050411',
          nombre: 'PUCACOLPA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050412',
          nombre: 'CHACA',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050413',
          nombre: 'PUTIS',
          codigoProvincia: '0504',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050501',
          nombre: 'SAN MIGUEL',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050502',
          nombre: 'ANCO',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050503',
          nombre: 'AYNA',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050504',
          nombre: 'CHILCAS',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050505',
          nombre: 'CHUNGUI',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050506',
          nombre: 'LUIS CARRANZA',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050507',
          nombre: 'SANTA ROSA',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050508',
          nombre: 'TAMBO',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050509',
          nombre: 'SAMUGARI',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050510',
          nombre: 'ANCHIHUAY',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050511',
          nombre: 'ORONCCOY',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050512',
          nombre: 'UNION PROGRESO',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050513',
          nombre: 'RIO MAGDALENA',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050514',
          nombre: 'NINABAMBA',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050515',
          nombre: 'PATIBAMBA',
          codigoProvincia: '0505',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050601',
          nombre: 'PUQUIO',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050602',
          nombre: 'AUCARA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050603',
          nombre: 'CABANA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050604',
          nombre: 'CARMEN SALCEDO',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050605',
          nombre: 'CHAVIÑA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050606',
          nombre: 'CHIPAO',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050607',
          nombre: 'HUAC-HUAS',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050608',
          nombre: 'LARAMATE',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050609',
          nombre: 'LEONCIO PRADO',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050610',
          nombre: 'LLAUTA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050611',
          nombre: 'LUCANAS',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050612',
          nombre: 'OCAÑA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050613',
          nombre: 'OTOCA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050614',
          nombre: 'SAISA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050615',
          nombre: 'SAN CRISTOBAL',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050616',
          nombre: 'SAN JUAN',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050617',
          nombre: 'SAN PEDRO',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050618',
          nombre: 'SAN PEDRO DE PALCO',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050619',
          nombre: 'SANCOS',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050620',
          nombre: 'SANTA ANA DE HUAYCAHUACHO',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050621',
          nombre: 'SANTA LUCIA',
          codigoProvincia: '0506',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050701',
          nombre: 'CORACORA',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050702',
          nombre: 'CHUMPI',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050703',
          nombre: 'CORONEL CASTAÑEDA',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050704',
          nombre: 'PACAPAUSA',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050705',
          nombre: 'PULLO',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050706',
          nombre: 'PUYUSCA',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050707',
          nombre: 'SAN FRANCISCO DE RIVACAYCO',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050708',
          nombre: 'UPAHUACHO',
          codigoProvincia: '0507',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050801',
          nombre: 'PAUSA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050802',
          nombre: 'COLTA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050803',
          nombre: 'CORCULLA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050804',
          nombre: 'LAMPA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050805',
          nombre: 'MARCABAMBA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050806',
          nombre: 'OYOLO',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050807',
          nombre: 'PARARCA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050808',
          nombre: 'SAN JAVIER DE ALPABAMBA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050809',
          nombre: 'SAN JOSE DE USHUA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050810',
          nombre: 'SARA SARA',
          codigoProvincia: '0508',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050901',
          nombre: 'QUEROBAMBA',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050902',
          nombre: 'BELEN',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050903',
          nombre: 'CHALCOS',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050904',
          nombre: 'CHILCAYOC',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050905',
          nombre: 'HUACAÑA',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050906',
          nombre: 'MORCOLLA',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050907',
          nombre: 'PAICO',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050908',
          nombre: 'SAN PEDRO DE LARCAY',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050909',
          nombre: 'SAN SALVADOR DE QUIJE',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050910',
          nombre: 'SANTIAGO DE PAUCARAY',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '050911',
          nombre: 'SORAS',
          codigoProvincia: '0509',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051001',
          nombre: 'HUANCAPI',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051002',
          nombre: 'ALCAMENCA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051003',
          nombre: 'APONGO',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051004',
          nombre: 'ASQUIPATA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051005',
          nombre: 'CANARIA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051006',
          nombre: 'CAYARA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051007',
          nombre: 'COLCA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051008',
          nombre: 'HUAMANQUIQUIA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051009',
          nombre: 'HUANCARAYLLA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051010',
          nombre: 'HUALLA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051011',
          nombre: 'SARHUA',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051012',
          nombre: 'VILCANCHOS',
          codigoProvincia: '0510',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051101',
          nombre: 'VILCAS HUAMAN',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051102',
          nombre: 'ACCOMARCA',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051103',
          nombre: 'CARHUANCA',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051104',
          nombre: 'CONCEPCION',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051105',
          nombre: 'HUAMBALPA',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051106',
          nombre: 'INDEPENDENCIA',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051107',
          nombre: 'SAURAMA',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '051108',
          nombre: 'VISCHONGO',
          codigoProvincia: '0511',
          codigoDepartamento: '05'),
      Distrito(
          codigo: '060101',
          nombre: 'CAJAMARCA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060102',
          nombre: 'ASUNCION',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060103',
          nombre: 'CHETILLA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060104',
          nombre: 'COSPAN',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060105',
          nombre: 'ENCAÑADA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060106',
          nombre: 'JESUS',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060107',
          nombre: 'LLACANORA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060108',
          nombre: 'LOS BAÑOS DEL INCA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060109',
          nombre: 'MAGDALENA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060110',
          nombre: 'MATARA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060111',
          nombre: 'NAMORA',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060112',
          nombre: 'SAN JUAN',
          codigoProvincia: '0601',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060201',
          nombre: 'CAJABAMBA',
          codigoProvincia: '0602',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060202',
          nombre: 'CACHACHI',
          codigoProvincia: '0602',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060203',
          nombre: 'CONDEBAMBA',
          codigoProvincia: '0602',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060204',
          nombre: 'SITACOCHA',
          codigoProvincia: '0602',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060301',
          nombre: 'CELENDIN',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060302',
          nombre: 'CHUMUCH',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060303',
          nombre: 'CORTEGANA',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060304',
          nombre: 'HUASMIN',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060305',
          nombre: 'JORGE CHAVEZ',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060306',
          nombre: 'JOSE GALVEZ',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060307',
          nombre: 'MIGUEL IGLESIAS',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060308',
          nombre: 'OXAMARCA',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060309',
          nombre: 'SOROCHUCO',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060310',
          nombre: 'SUCRE',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060311',
          nombre: 'UTCO',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060312',
          nombre: 'LA LIBERTAD DE PALLAN',
          codigoProvincia: '0603',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060401',
          nombre: 'CHOTA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060402',
          nombre: 'ANGUIA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060403',
          nombre: 'CHADIN',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060404',
          nombre: 'CHIGUIRIP',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060405',
          nombre: 'CHIMBAN',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060406',
          nombre: 'CHOROPAMPA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060407',
          nombre: 'COCHABAMBA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060408',
          nombre: 'CONCHAN',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060409',
          nombre: 'HUAMBOS',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060410',
          nombre: 'LAJAS',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060411',
          nombre: 'LLAMA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060412',
          nombre: 'MIRACOSTA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060413',
          nombre: 'PACCHA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060414',
          nombre: 'PION',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060415',
          nombre: 'QUEROCOTO',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060416',
          nombre: 'SAN JUAN DE LICUPIS',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060417',
          nombre: 'TACABAMBA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060418',
          nombre: 'TOCMOCHE',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060419',
          nombre: 'CHALAMARCA',
          codigoProvincia: '0604',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060501',
          nombre: 'CONTUMAZA',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060502',
          nombre: 'CHILETE',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060503',
          nombre: 'CUPISNIQUE',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060504',
          nombre: 'GUZMANGO',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060505',
          nombre: 'SAN BENITO',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060506',
          nombre: 'SANTA CRUZ DE TOLED',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060507',
          nombre: 'TANTARICA',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060508',
          nombre: 'YONAN',
          codigoProvincia: '0605',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060601',
          nombre: 'CUTERVO',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060602',
          nombre: 'CALLAYUC',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060603',
          nombre: 'CHOROS',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060604',
          nombre: 'CUJILLO',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060605',
          nombre: 'LA RAMADA',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060606',
          nombre: 'PIMPINGOS',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060607',
          nombre: 'QUEROCOTILLO',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060608',
          nombre: 'SAN ANDRES DE CUTERVO',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060609',
          nombre: 'SAN JUAN DE CUTERVO',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060610',
          nombre: 'SAN LUIS DE LUCMA',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060611',
          nombre: 'SANTA CRUZ',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060612',
          nombre: 'SANTO DOMINGO DE LA CAPILLA',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060613',
          nombre: 'SANTO TOMAS',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060614',
          nombre: 'SOCOTA',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060615',
          nombre: 'TORIBIO CASANOVA',
          codigoProvincia: '0606',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060701',
          nombre: 'BAMBAMARCA',
          codigoProvincia: '0607',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060702',
          nombre: 'CHUGUR',
          codigoProvincia: '0607',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060703',
          nombre: 'HUALGAYOC',
          codigoProvincia: '0607',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060801',
          nombre: 'JAEN',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060802',
          nombre: 'BELLAVISTA',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060803',
          nombre: 'CHONTALI',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060804',
          nombre: 'COLASAY',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060805',
          nombre: 'HUABAL',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060806',
          nombre: 'LAS PIRIAS',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060807',
          nombre: 'POMAHUACA',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060808',
          nombre: 'PUCARA',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060809',
          nombre: 'SALLIQUE',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060810',
          nombre: 'SAN FELIPE',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060811',
          nombre: 'SAN JOSE DEL ALTO',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060812',
          nombre: 'SANTA ROSA',
          codigoProvincia: '0608',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060901',
          nombre: 'SAN IGNACIO',
          codigoProvincia: '0609',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060902',
          nombre: 'CHIRINOS',
          codigoProvincia: '0609',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060903',
          nombre: 'HUARANGO',
          codigoProvincia: '0609',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060904',
          nombre: 'LA COIPA',
          codigoProvincia: '0609',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060905',
          nombre: 'NAMBALLE',
          codigoProvincia: '0609',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060906',
          nombre: 'SAN JOSE DE LOURDES',
          codigoProvincia: '0609',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '060907',
          nombre: 'TABACONAS',
          codigoProvincia: '0609',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061001',
          nombre: 'PEDRO GALVEZ',
          codigoProvincia: '0610',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061002',
          nombre: 'CHANCAY',
          codigoProvincia: '0610',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061003',
          nombre: 'EDUARDO VILLANUEVA',
          codigoProvincia: '0610',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061004',
          nombre: 'GREGORIO PITA',
          codigoProvincia: '0610',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061005',
          nombre: 'ICHOCAN',
          codigoProvincia: '0610',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061006',
          nombre: 'JOSE MANUEL QUIROZ',
          codigoProvincia: '0610',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061007',
          nombre: 'JOSE SABOGAL',
          codigoProvincia: '0610',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061101',
          nombre: 'SAN MIGUEL',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061102',
          nombre: 'BOLIVAR',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061103',
          nombre: 'CALQUIS',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061104',
          nombre: 'CATILLUC',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061105',
          nombre: 'EL PRADO',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061106',
          nombre: 'LA FLORIDA',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061107',
          nombre: 'LLAPA',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061108',
          nombre: 'NANCHOC',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061109',
          nombre: 'NIEPOS',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061110',
          nombre: 'SAN GREGORIO',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061111',
          nombre: 'SAN SILVESTRE DE COCHAN',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061112',
          nombre: 'TONGOD',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061113',
          nombre: 'UNION AGUA BLANCA',
          codigoProvincia: '0611',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061201',
          nombre: 'SAN PABLO',
          codigoProvincia: '0612',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061202',
          nombre: 'SAN BERNARDINO',
          codigoProvincia: '0612',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061203',
          nombre: 'SAN LUIS',
          codigoProvincia: '0612',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061204',
          nombre: 'TUMBADEN',
          codigoProvincia: '0612',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061301',
          nombre: 'SANTA CRUZ',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061302',
          nombre: 'ANDABAMBA',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061303',
          nombre: 'CATACHE',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061304',
          nombre: 'CHANCAYBAÑOS',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061305',
          nombre: 'LA ESPERANZA',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061306',
          nombre: 'NINABAMBA',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061307',
          nombre: 'PULAN',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061308',
          nombre: 'SAUCEPAMPA',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061309',
          nombre: 'SEXI',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061310',
          nombre: 'UTICYACU',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '061311',
          nombre: 'YAUYUCAN',
          codigoProvincia: '0613',
          codigoDepartamento: '06'),
      Distrito(
          codigo: '070101',
          nombre: 'CALLAO',
          codigoProvincia: '0701',
          codigoDepartamento: '07'),
      Distrito(
          codigo: '070102',
          nombre: 'BELLAVISTA',
          codigoProvincia: '0701',
          codigoDepartamento: '07'),
      Distrito(
          codigo: '070103',
          nombre: 'CARMEN DE LA LEGUA REYNOSO',
          codigoProvincia: '0701',
          codigoDepartamento: '07'),
      Distrito(
          codigo: '070104',
          nombre: 'LA PERLA',
          codigoProvincia: '0701',
          codigoDepartamento: '07'),
      Distrito(
          codigo: '070105',
          nombre: 'LA PUNTA',
          codigoProvincia: '0701',
          codigoDepartamento: '07'),
      Distrito(
          codigo: '070106',
          nombre: 'VENTANILLA',
          codigoProvincia: '0701',
          codigoDepartamento: '07'),
      Distrito(
          codigo: '070107',
          nombre: 'MI PERU',
          codigoProvincia: '0701',
          codigoDepartamento: '07'),
      Distrito(
          codigo: '080101',
          nombre: 'CUSCO',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080102',
          nombre: 'CCORCA',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080103',
          nombre: 'POROY',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080104',
          nombre: 'SAN JERONIMO',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080105',
          nombre: 'SAN SEBASTIAN',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080106',
          nombre: 'SANTIAGO',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080107',
          nombre: 'SAYLLA',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080108',
          nombre: 'WANCHAQ',
          codigoProvincia: '0801',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080201',
          nombre: 'ACOMAYO',
          codigoProvincia: '0802',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080202',
          nombre: 'ACOPIA',
          codigoProvincia: '0802',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080203',
          nombre: 'ACOS',
          codigoProvincia: '0802',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080204',
          nombre: 'MOSOC LLACTA',
          codigoProvincia: '0802',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080205',
          nombre: 'POMACANCHI',
          codigoProvincia: '0802',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080206',
          nombre: 'RONDOCAN',
          codigoProvincia: '0802',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080207',
          nombre: 'SANGARARA',
          codigoProvincia: '0802',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080301',
          nombre: 'ANTA',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080302',
          nombre: 'ANCAHUASI',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080303',
          nombre: 'CACHIMAYO',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080304',
          nombre: 'CHINCHAYPUJIO',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080305',
          nombre: 'HUAROCONDO',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080306',
          nombre: 'LIMATAMBO',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080307',
          nombre: 'MOLLEPATA',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080308',
          nombre: 'PUCYURA',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080309',
          nombre: 'ZURITE',
          codigoProvincia: '0803',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080401',
          nombre: 'CALCA',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080402',
          nombre: 'COYA',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080403',
          nombre: 'LAMAY',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080404',
          nombre: 'LARES',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080405',
          nombre: 'PISAC',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080406',
          nombre: 'SAN SALVADOR',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080407',
          nombre: 'TARAY',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080408',
          nombre: 'YANATILE',
          codigoProvincia: '0804',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080501',
          nombre: 'YANAOCA',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080502',
          nombre: 'CHECCA',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080503',
          nombre: 'KUNTURKANKI',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080504',
          nombre: 'LANGUI',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080505',
          nombre: 'LAYO',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080506',
          nombre: 'PAMPAMARCA',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080507',
          nombre: 'QUEHUE',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080508',
          nombre: 'TUPAC AMARU',
          codigoProvincia: '0805',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080601',
          nombre: 'SICUANI',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080602',
          nombre: 'CHECACUPE',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080603',
          nombre: 'COMBAPATA',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080604',
          nombre: 'MARANGANI',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080605',
          nombre: 'PITUMARCA',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080606',
          nombre: 'SAN PABLO',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080607',
          nombre: 'SAN PEDRO',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080608',
          nombre: 'TINTA',
          codigoProvincia: '0806',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080701',
          nombre: 'SANTO TOMAS',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080702',
          nombre: 'CAPACMARCA',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080703',
          nombre: 'CHAMACA',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080704',
          nombre: 'COLQUEMARCA',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080705',
          nombre: 'LIVITACA',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080706',
          nombre: 'LLUSCO',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080707',
          nombre: 'QUIÑOTA',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080708',
          nombre: 'VELILLE',
          codigoProvincia: '0807',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080801',
          nombre: 'ESPINAR',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080802',
          nombre: 'CONDOROMA',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080803',
          nombre: 'COPORAQUE',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080804',
          nombre: 'OCORURO',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080805',
          nombre: 'PALLPATA',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080806',
          nombre: 'PICHIGUA',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080807',
          nombre: 'SUYCKUTAMBO',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080808',
          nombre: 'ALTO PICHIGUA',
          codigoProvincia: '0808',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080901',
          nombre: 'SANTA ANA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080902',
          nombre: 'ECHARATE',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080903',
          nombre: 'HUAYOPATA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080904',
          nombre: 'MARANURA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080905',
          nombre: 'OCOBAMBA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080906',
          nombre: 'QUELLOUNO',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080907',
          nombre: 'KIMBIRI',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080908',
          nombre: 'SANTA TERESA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080909',
          nombre: 'VILCABAMBA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080910',
          nombre: 'PICHARI',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080911',
          nombre: 'INKAWASI',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080912',
          nombre: 'VILLA VIRGEN',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080913',
          nombre: 'VILLA KINTIARINA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080914',
          nombre: 'MEGANTONI',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080915',
          nombre: 'KUMPIRUSHIATO',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080916',
          nombre: 'CIELO PUNCO',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080917',
          nombre: 'MANITEA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '080918',
          nombre: 'UNION ASHANINKA',
          codigoProvincia: '0809',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081001',
          nombre: 'PARURO',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081002',
          nombre: 'ACCHA',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081003',
          nombre: 'CCAPI',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081004',
          nombre: 'COLCHA',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081005',
          nombre: 'HUANOQUITE',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081006',
          nombre: 'OMACHA',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081007',
          nombre: 'PACCARITAMBO',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081008',
          nombre: 'PILLPINTO',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081009',
          nombre: 'YAURISQUE',
          codigoProvincia: '0810',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081101',
          nombre: 'PAUCARTAMBO',
          codigoProvincia: '0811',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081102',
          nombre: 'CAICAY',
          codigoProvincia: '0811',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081103',
          nombre: 'CHALLABAMBA',
          codigoProvincia: '0811',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081104',
          nombre: 'COLQUEPATA',
          codigoProvincia: '0811',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081105',
          nombre: 'HUANCARANI',
          codigoProvincia: '0811',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081106',
          nombre: 'KOSÑIPATA',
          codigoProvincia: '0811',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081201',
          nombre: 'URCOS',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081202',
          nombre: 'ANDAHUAYLILLAS',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081203',
          nombre: 'CAMANTI',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081204',
          nombre: 'CCARHUAYO',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081205',
          nombre: 'CCATCA',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081206',
          nombre: 'CUSIPATA',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081207',
          nombre: 'HUARO',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081208',
          nombre: 'LUCRE',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081209',
          nombre: 'MARCAPATA',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081210',
          nombre: 'OCONGATE',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081211',
          nombre: 'OROPESA',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081212',
          nombre: 'QUIQUIJANA',
          codigoProvincia: '0812',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081301',
          nombre: 'URUBAMBA',
          codigoProvincia: '0813',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081302',
          nombre: 'CHINCHERO',
          codigoProvincia: '0813',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081303',
          nombre: 'HUAYLLABAMBA',
          codigoProvincia: '0813',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081304',
          nombre: 'MACHUPICCHU',
          codigoProvincia: '0813',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081305',
          nombre: 'MARAS',
          codigoProvincia: '0813',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081306',
          nombre: 'OLLANTAYTAMBO',
          codigoProvincia: '0813',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '081307',
          nombre: 'YUCAY',
          codigoProvincia: '0813',
          codigoDepartamento: '08'),
      Distrito(
          codigo: '090101',
          nombre: 'HUANCAVELICA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090102',
          nombre: 'ACOBAMBILLA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090103',
          nombre: 'ACORIA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090104',
          nombre: 'CONAYCA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090105',
          nombre: 'CUENCA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090106',
          nombre: 'HUACHOCOLPA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090107',
          nombre: 'HUAYLLAHUARA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090108',
          nombre: 'IZCUCHACA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090109',
          nombre: 'LARIA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090110',
          nombre: 'MANTA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090111',
          nombre: 'MARISCAL CACERES',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090112',
          nombre: 'MOYA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090113',
          nombre: 'NUEVO OCCORO',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090114',
          nombre: 'PALCA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090115',
          nombre: 'PILCHACA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090116',
          nombre: 'VILCA',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090117',
          nombre: 'YAULI',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090118',
          nombre: 'ASCENSION',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090119',
          nombre: 'HUANDO',
          codigoProvincia: '0901',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090201',
          nombre: 'ACOBAMBA',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090202',
          nombre: 'ANDABAMBA',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090203',
          nombre: 'ANTA',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090204',
          nombre: 'CAJA',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090205',
          nombre: 'MARCAS',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090206',
          nombre: 'PAUCARA',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090207',
          nombre: 'POMACOCHA',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090208',
          nombre: 'ROSARIO',
          codigoProvincia: '0902',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090301',
          nombre: 'LIRCAY',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090302',
          nombre: 'ANCHONGA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090303',
          nombre: 'CALLANMARCA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090304',
          nombre: 'CCOCHACCASA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090305',
          nombre: 'CHINCHO',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090306',
          nombre: 'CONGALLA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090307',
          nombre: 'HUANCA-HUANCA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090308',
          nombre: 'HUAYLLAY GRANDE',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090309',
          nombre: 'JULCAMARCA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090310',
          nombre: 'SAN ANTONIO DE ANTAPARCO',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090311',
          nombre: 'SANTO TOMAS DE PATA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090312',
          nombre: 'SECCLLA',
          codigoProvincia: '0903',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090401',
          nombre: 'CASTROVIRREYNA',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090402',
          nombre: 'ARMA',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090403',
          nombre: 'AURAHUA',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090404',
          nombre: 'CAPILLAS',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090405',
          nombre: 'CHUPAMARCA',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090406',
          nombre: 'COCAS',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090407',
          nombre: 'HUACHOS',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090408',
          nombre: 'HUAMATAMBO',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090409',
          nombre: 'MOLLEPAMPA',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090410',
          nombre: 'SAN JUAN',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090411',
          nombre: 'SANTA ANA',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090412',
          nombre: 'TANTARA',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090413',
          nombre: 'TICRAPO',
          codigoProvincia: '0904',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090501',
          nombre: 'CHURCAMPA',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090502',
          nombre: 'ANCO',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090503',
          nombre: 'CHINCHIHUASI',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090504',
          nombre: 'EL CARMEN',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090505',
          nombre: 'LA MERCED',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090506',
          nombre: 'LOCROJA',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090507',
          nombre: 'PAUCARBAMBA',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090508',
          nombre: 'SAN MIGUEL DE MAYOCC',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090509',
          nombre: 'SAN PEDRO DE CORIS',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090510',
          nombre: 'PACHAMARCA',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090511',
          nombre: 'COSME',
          codigoProvincia: '0905',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090601',
          nombre: 'HUAYTARA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090602',
          nombre: 'AYAVI',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090603',
          nombre: 'CORDOVA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090604',
          nombre: 'HUAYACUNDO ARMA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090605',
          nombre: 'LARAMARCA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090606',
          nombre: 'OCOYO',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090607',
          nombre: 'PILPICHACA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090608',
          nombre: 'QUERCO',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090609',
          nombre: 'QUITO-ARMA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090610',
          nombre: 'SAN ANTONIO DE CUSICANCHA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090611',
          nombre: 'SAN FRANCISCO DE SANGAYAICO',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090612',
          nombre: 'SAN ISIDRO',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090613',
          nombre: 'SANTIAGO DE CHOCORVOS',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090614',
          nombre: 'SANTIAGO DE QUIRAHUARA',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090615',
          nombre: 'SANTO DOMINGO DE CAPILLAS',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090616',
          nombre: 'TAMBO',
          codigoProvincia: '0906',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090701',
          nombre: 'PAMPAS',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090702',
          nombre: 'ACOSTAMBO',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090703',
          nombre: 'ACRAQUIA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090704',
          nombre: 'AHUAYCHA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090705',
          nombre: 'COLCABAMBA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090706',
          nombre: 'DANIEL HERNANDEZ',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090707',
          nombre: 'HUACHOCOLPA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090709',
          nombre: 'HUARIBAMBA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090710',
          nombre: 'ÑAHUIMPUQUIO',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090711',
          nombre: 'PAZOS',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090713',
          nombre: 'QUISHUAR',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090714',
          nombre: 'SALCABAMBA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090715',
          nombre: 'SALCAHUASI',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090716',
          nombre: 'SAN MARCOS DE ROCCHAC',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090717',
          nombre: 'SURCUBAMBA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090718',
          nombre: 'TINTAY PUNCU',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090719',
          nombre: 'QUICHUAS',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090720',
          nombre: 'ANDAYMARCA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090721',
          nombre: 'ROBLE',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090722',
          nombre: 'PICHOS',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090723',
          nombre: 'SANTIAGO DE TUCUMA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090724',
          nombre: 'LAMBRAS',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '090725',
          nombre: 'COCHABAMBA',
          codigoProvincia: '0907',
          codigoDepartamento: '09'),
      Distrito(
          codigo: '100101',
          nombre: 'HUANUCO',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100102',
          nombre: 'AMARILIS',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100103',
          nombre: 'CHINCHAO',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100104',
          nombre: 'CHURUBAMBA',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100105',
          nombre: 'MARGOS',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100106',
          nombre: 'QUISQUI (KICHKI)',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100107',
          nombre: 'SAN FRANCISCO DE CAYRAN',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100108',
          nombre: 'SAN PEDRO DE CHAULAN',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100109',
          nombre: 'SANTA MARIA DEL VALLE',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100110',
          nombre: 'YARUMAYO',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100111',
          nombre: 'PILLCO MARCA',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100112',
          nombre: 'YACUS',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100113',
          nombre: 'SAN PABLO DE PILLAO',
          codigoProvincia: '1001',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100201',
          nombre: 'AMBO',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100202',
          nombre: 'CAYNA',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100203',
          nombre: 'COLPAS',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100204',
          nombre: 'CONCHAMARCA',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100205',
          nombre: 'HUACAR',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100206',
          nombre: 'SAN FRANCISCO',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100207',
          nombre: 'SAN RAFAEL',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100208',
          nombre: 'TOMAY KICHWA',
          codigoProvincia: '1002',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100301',
          nombre: 'LA UNION',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100307',
          nombre: 'CHUQUIS',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100311',
          nombre: 'MARIAS',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100313',
          nombre: 'PACHAS',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100316',
          nombre: 'QUIVILLA',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100317',
          nombre: 'RIPAN',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100321',
          nombre: 'SHUNQUI',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100322',
          nombre: 'SILLAPATA',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100323',
          nombre: 'YANAS',
          codigoProvincia: '1003',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100401',
          nombre: 'HUACAYBAMBA',
          codigoProvincia: '1004',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100402',
          nombre: 'CANCHABAMBA',
          codigoProvincia: '1004',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100403',
          nombre: 'COCHABAMBA',
          codigoProvincia: '1004',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100404',
          nombre: 'PINRA',
          codigoProvincia: '1004',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100501',
          nombre: 'LLATA',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100502',
          nombre: 'ARANCAY',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100503',
          nombre: 'CHAVIN DE PARIARCA',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100504',
          nombre: 'JACAS GRANDE',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100505',
          nombre: 'JIRCAN',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100506',
          nombre: 'MIRAFLORES',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100507',
          nombre: 'MONZON',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100508',
          nombre: 'PUNCHAO',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100509',
          nombre: 'PUÑOS',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100510',
          nombre: 'SINGA',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100511',
          nombre: 'TANTAMAYO',
          codigoProvincia: '1005',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100601',
          nombre: 'RUPA-RUPA',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100602',
          nombre: 'DANIEL ALOMIA ROBLES',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100603',
          nombre: 'HERMILIO VALDIZAN',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100604',
          nombre: 'JOSE CRESPO Y CASTILLO',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100605',
          nombre: 'LUYANDO',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100606',
          nombre: 'MARIANO DAMASO BERAUN',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100607',
          nombre: 'PUCAYACU',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100608',
          nombre: 'CASTILLO GRANDE',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100609',
          nombre: 'PUEBLO NUEVO',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100610',
          nombre: 'SANTO DOMINGO DE ANDA',
          codigoProvincia: '1006',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100701',
          nombre: 'HUACRACHUCO',
          codigoProvincia: '1007',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100702',
          nombre: 'CHOLON',
          codigoProvincia: '1007',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100703',
          nombre: 'SAN BUENAVENTURA',
          codigoProvincia: '1007',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100704',
          nombre: 'LA MORADA',
          codigoProvincia: '1007',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100705',
          nombre: 'SANTA ROSA DE ALTO YANAJANCA',
          codigoProvincia: '1007',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100801',
          nombre: 'PANAO',
          codigoProvincia: '1008',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100802',
          nombre: 'CHAGLLA',
          codigoProvincia: '1008',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100803',
          nombre: 'MOLINO',
          codigoProvincia: '1008',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100804',
          nombre: 'UMARI',
          codigoProvincia: '1008',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100901',
          nombre: 'PUERTO INCA',
          codigoProvincia: '1009',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100902',
          nombre: 'CODO DEL POZUZO',
          codigoProvincia: '1009',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100903',
          nombre: 'HONORIA',
          codigoProvincia: '1009',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100904',
          nombre: 'TOURNAVISTA',
          codigoProvincia: '1009',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '100905',
          nombre: 'YUYAPICHIS',
          codigoProvincia: '1009',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101001',
          nombre: 'JESUS',
          codigoProvincia: '1010',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101002',
          nombre: 'BAÑOS',
          codigoProvincia: '1010',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101003',
          nombre: 'JIVIA',
          codigoProvincia: '1010',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101004',
          nombre: 'QUEROPALCA',
          codigoProvincia: '1010',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101005',
          nombre: 'RONDOS',
          codigoProvincia: '1010',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101006',
          nombre: 'SAN FRANCISCO DE ASIS',
          codigoProvincia: '1010',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101007',
          nombre: 'SAN MIGUEL DE CAURI',
          codigoProvincia: '1010',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101101',
          nombre: 'CHAVINILLO',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101102',
          nombre: 'CAHUAC',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101103',
          nombre: 'CHACABAMBA',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101104',
          nombre: 'APARICIO POMARES',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101105',
          nombre: 'JACAS CHICO',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101106',
          nombre: 'OBAS',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101107',
          nombre: 'PAMPAMARCA',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '101108',
          nombre: 'CHORAS',
          codigoProvincia: '1011',
          codigoDepartamento: '10'),
      Distrito(
          codigo: '110101',
          nombre: 'ICA',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110102',
          nombre: 'LA TINGUIÑA',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110103',
          nombre: 'LOS AQUIJES',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110104',
          nombre: 'OCUCAJE',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110105',
          nombre: 'PACHACUTEC',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110106',
          nombre: 'PARCONA',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110107',
          nombre: 'PUEBLO NUEVO',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110108',
          nombre: 'SALAS',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110109',
          nombre: 'SAN JOSE DE LOS MOLINOS',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110110',
          nombre: 'SAN JUAN BAUTISTA',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110111',
          nombre: 'SANTIAGO',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110112',
          nombre: 'SUBTANJALLA',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110113',
          nombre: 'TATE',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110114',
          nombre: 'YAUCA DEL ROSARIO',
          codigoProvincia: '1101',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110201',
          nombre: 'CHINCHA ALTA',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110202',
          nombre: 'ALTO LARAN',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110203',
          nombre: 'CHAVIN',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110204',
          nombre: 'CHINCHA BAJA',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110205',
          nombre: 'EL CARMEN',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110206',
          nombre: 'GROCIO PRADO',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110207',
          nombre: 'PUEBLO NUEVO',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110208',
          nombre: 'SAN JUAN DE YANAC',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110209',
          nombre: 'SAN PEDRO DE HUACARPANA',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110210',
          nombre: 'SUNAMPE',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110211',
          nombre: 'TAMBO DE MORA',
          codigoProvincia: '1102',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110301',
          nombre: 'NASCA',
          codigoProvincia: '1103',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110302',
          nombre: 'CHANGUILLO',
          codigoProvincia: '1103',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110303',
          nombre: 'EL INGENIO',
          codigoProvincia: '1103',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110304',
          nombre: 'MARCONA',
          codigoProvincia: '1103',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110305',
          nombre: 'VISTA ALEGRE',
          codigoProvincia: '1103',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110401',
          nombre: 'PALPA',
          codigoProvincia: '1104',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110402',
          nombre: 'LLIPATA',
          codigoProvincia: '1104',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110403',
          nombre: 'RIO GRANDE',
          codigoProvincia: '1104',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110404',
          nombre: 'SANTA CRUZ',
          codigoProvincia: '1104',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110405',
          nombre: 'TIBILLO',
          codigoProvincia: '1104',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110501',
          nombre: 'PISCO',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110502',
          nombre: 'HUANCANO',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110503',
          nombre: 'HUMAY',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110504',
          nombre: 'INDEPENDENCIA',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110505',
          nombre: 'PARACAS',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110506',
          nombre: 'SAN ANDRES',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110507',
          nombre: 'SAN CLEMENTE',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '110508',
          nombre: 'TUPAC AMARU INCA',
          codigoProvincia: '1105',
          codigoDepartamento: '11'),
      Distrito(
          codigo: '120101',
          nombre: 'HUANCAYO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120104',
          nombre: 'CARHUACALLANGA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120105',
          nombre: 'CHACAPAMPA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120106',
          nombre: 'CHICCHE',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120107',
          nombre: 'CHILCA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120108',
          nombre: 'CHONGOS ALTO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120111',
          nombre: 'CHUPURO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120112',
          nombre: 'COLCA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120113',
          nombre: 'CULLHUAS',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120114',
          nombre: 'EL TAMBO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120116',
          nombre: 'HUACRAPUQUIO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120117',
          nombre: 'HUALHUAS',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120119',
          nombre: 'HUANCAN',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120120',
          nombre: 'HUASICANCHA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120121',
          nombre: 'HUAYUCACHI',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120122',
          nombre: 'INGENIO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120124',
          nombre: 'PARIAHUANCA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120125',
          nombre: 'PILCOMAYO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120126',
          nombre: 'PUCARA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120127',
          nombre: 'QUICHUAY',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120128',
          nombre: 'QUILCAS',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120129',
          nombre: 'SAN AGUSTIN',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120130',
          nombre: 'SAN JERONIMO DE TUNAN',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120132',
          nombre: 'SAÑO',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120133',
          nombre: 'SAPALLANGA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120134',
          nombre: 'SICAYA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120135',
          nombre: 'SANTO DOMINGO DE ACOBAMBA',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120136',
          nombre: 'VIQUES',
          codigoProvincia: '1201',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120201',
          nombre: 'CONCEPCION',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120202',
          nombre: 'ACO',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120203',
          nombre: 'ANDAMARCA',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120204',
          nombre: 'CHAMBARA',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120205',
          nombre: 'COCHAS',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120206',
          nombre: 'COMAS',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120207',
          nombre: 'HEROINAS TOLEDO',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120208',
          nombre: 'MANZANARES',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120209',
          nombre: 'MARISCAL CASTILLA',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120210',
          nombre: 'MATAHUASI',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120211',
          nombre: 'MITO',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120212',
          nombre: 'NUEVE DE JULIO',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120213',
          nombre: 'ORCOTUNA',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120214',
          nombre: 'SAN JOSE DE QUERO',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120215',
          nombre: 'SANTA ROSA DE OCOPA',
          codigoProvincia: '1202',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120301',
          nombre: 'CHANCHAMAYO',
          codigoProvincia: '1203',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120302',
          nombre: 'PERENE',
          codigoProvincia: '1203',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120303',
          nombre: 'PICHANAQUI',
          codigoProvincia: '1203',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120304',
          nombre: 'SAN LUIS DE SHUARO',
          codigoProvincia: '1203',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120305',
          nombre: 'SAN RAMON',
          codigoProvincia: '1203',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120306',
          nombre: 'VITOC',
          codigoProvincia: '1203',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120401',
          nombre: 'JAUJA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120402',
          nombre: 'ACOLLA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120403',
          nombre: 'APATA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120404',
          nombre: 'ATAURA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120405',
          nombre: 'CANCHAYLLO',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120406',
          nombre: 'CURICACA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120407',
          nombre: 'EL MANTARO',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120408',
          nombre: 'HUAMALI',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120409',
          nombre: 'HUARIPAMPA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120410',
          nombre: 'HUERTAS',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120411',
          nombre: 'JANJAILLO',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120412',
          nombre: 'JULCAN',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120413',
          nombre: 'LEONOR ORDOÑEZ',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120414',
          nombre: 'LLOCLLAPAMPA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120415',
          nombre: 'MARCO',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120416',
          nombre: 'MASMA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120417',
          nombre: 'MASMA CHICCHE',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120418',
          nombre: 'MOLINOS',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120419',
          nombre: 'MONOBAMBA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120420',
          nombre: 'MUQUI',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120421',
          nombre: 'MUQUIYAUYO',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120422',
          nombre: 'PACA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120423',
          nombre: 'PACCHA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120424',
          nombre: 'PANCAN',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120425',
          nombre: 'PARCO',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120426',
          nombre: 'POMACANCHA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120427',
          nombre: 'RICRAN',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120428',
          nombre: 'SAN LORENZO',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120429',
          nombre: 'SAN PEDRO DE CHUNAN',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120430',
          nombre: 'SAUSA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120431',
          nombre: 'SINCOS',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120432',
          nombre: 'TUNAN MARCA',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120433',
          nombre: 'YAULI',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120434',
          nombre: 'YAUYOS',
          codigoProvincia: '1204',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120501',
          nombre: 'JUNIN',
          codigoProvincia: '1205',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120502',
          nombre: 'CARHUAMAYO',
          codigoProvincia: '1205',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120503',
          nombre: 'ONDORES',
          codigoProvincia: '1205',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120504',
          nombre: 'ULCUMAYO',
          codigoProvincia: '1205',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120601',
          nombre: 'SATIPO',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120602',
          nombre: 'COVIRIALI',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120603',
          nombre: 'LLAYLLA',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120604',
          nombre: 'MAZAMARI',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120605',
          nombre: 'PAMPA HERMOSA',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120606',
          nombre: 'PANGOA',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120607',
          nombre: 'RIO NEGRO',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120608',
          nombre: 'RIO TAMBO',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120609',
          nombre: 'VIZCATÁN DEL ENE',
          codigoProvincia: '1206',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120701',
          nombre: 'TARMA',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120702',
          nombre: 'ACOBAMBA',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120703',
          nombre: 'HUARICOLCA',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120704',
          nombre: 'HUASAHUASI',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120705',
          nombre: 'LA UNION',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120706',
          nombre: 'PALCA',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120707',
          nombre: 'PALCAMAYO',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120708',
          nombre: 'SAN PEDRO DE CAJAS',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120709',
          nombre: 'TAPO',
          codigoProvincia: '1207',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120801',
          nombre: 'LA OROYA',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120802',
          nombre: 'CHACAPALPA',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120803',
          nombre: 'HUAY-HUAY',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120804',
          nombre: 'MARCAPOMACOCHA',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120805',
          nombre: 'MOROCOCHA',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120806',
          nombre: 'PACCHA',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120807',
          nombre: 'SANTA BARBARA DE CARHUACAYAN',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120808',
          nombre: 'SANTA ROSA DE SACCO',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120809',
          nombre: 'SUITUCANCHA',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120810',
          nombre: 'YAULI',
          codigoProvincia: '1208',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120901',
          nombre: 'CHUPACA',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120902',
          nombre: 'AHUAC',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120903',
          nombre: 'CHONGOS BAJO',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120904',
          nombre: 'HUACHAC',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120905',
          nombre: 'HUAMANCACA CHICO',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120906',
          nombre: 'SAN JUAN DE ISCOS',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120907',
          nombre: 'SAN JUAN DE JARPA',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120908',
          nombre: 'TRES DE DICIEMBRE',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '120909',
          nombre: 'YANACANCHA',
          codigoProvincia: '1209',
          codigoDepartamento: '12'),
      Distrito(
          codigo: '130101',
          nombre: 'TRUJILLO',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130102',
          nombre: 'EL PORVENIR',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130103',
          nombre: 'FLORENCIA DE MORA',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130104',
          nombre: 'HUANCHACO',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130105',
          nombre: 'LA ESPERANZA',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130106',
          nombre: 'LAREDO',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130107',
          nombre: 'MOCHE',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130108',
          nombre: 'POROTO',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130109',
          nombre: 'SALAVERRY',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130110',
          nombre: 'SIMBAL',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130111',
          nombre: 'VICTOR LARCO HERRERA',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130112',
          nombre: 'ALTO TRUJILLO',
          codigoProvincia: '1301',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130201',
          nombre: 'ASCOPE',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130202',
          nombre: 'CHICAMA',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130203',
          nombre: 'CHOCOPE',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130204',
          nombre: 'MAGDALENA DE CAO',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130205',
          nombre: 'PAIJAN',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130206',
          nombre: 'RAZURI',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130207',
          nombre: 'SANTIAGO DE CAO',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130208',
          nombre: 'CASA GRANDE',
          codigoProvincia: '1302',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130301',
          nombre: 'BOLIVAR',
          codigoProvincia: '1303',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130302',
          nombre: 'BAMBAMARCA',
          codigoProvincia: '1303',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130303',
          nombre: 'CONDORMARCA',
          codigoProvincia: '1303',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130304',
          nombre: 'LONGOTEA',
          codigoProvincia: '1303',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130305',
          nombre: 'UCHUMARCA',
          codigoProvincia: '1303',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130306',
          nombre: 'UCUNCHA',
          codigoProvincia: '1303',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130401',
          nombre: 'CHEPEN',
          codigoProvincia: '1304',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130402',
          nombre: 'PACANGA',
          codigoProvincia: '1304',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130403',
          nombre: 'PUEBLO NUEVO',
          codigoProvincia: '1304',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130501',
          nombre: 'JULCAN',
          codigoProvincia: '1305',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130502',
          nombre: 'CALAMARCA',
          codigoProvincia: '1305',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130503',
          nombre: 'CARABAMBA',
          codigoProvincia: '1305',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130504',
          nombre: 'HUASO',
          codigoProvincia: '1305',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130601',
          nombre: 'OTUZCO',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130602',
          nombre: 'AGALLPAMPA',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130604',
          nombre: 'CHARAT',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130605',
          nombre: 'HUARANCHAL',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130606',
          nombre: 'LA CUESTA',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130608',
          nombre: 'MACHE',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130610',
          nombre: 'PARANDAY',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130611',
          nombre: 'SALPO',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130613',
          nombre: 'SINSICAP',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130614',
          nombre: 'USQUIL',
          codigoProvincia: '1306',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130701',
          nombre: 'SAN PEDRO DE LLOC',
          codigoProvincia: '1307',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130702',
          nombre: 'GUADALUPE',
          codigoProvincia: '1307',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130703',
          nombre: 'JEQUETEPEQUE',
          codigoProvincia: '1307',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130704',
          nombre: 'PACASMAYO',
          codigoProvincia: '1307',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130705',
          nombre: 'SAN JOSE',
          codigoProvincia: '1307',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130801',
          nombre: 'TAYABAMBA',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130802',
          nombre: 'BULDIBUYO',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130803',
          nombre: 'CHILLIA',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130804',
          nombre: 'HUANCASPATA',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130805',
          nombre: 'HUAYLILLAS',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130806',
          nombre: 'HUAYO',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130807',
          nombre: 'ONGON',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130808',
          nombre: 'PARCOY',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130809',
          nombre: 'PATAZ',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130810',
          nombre: 'PIAS',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130811',
          nombre: 'SANTIAGO DE CHALLAS',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130812',
          nombre: 'TAURIJA',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130813',
          nombre: 'URPAY',
          codigoProvincia: '1308',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130901',
          nombre: 'HUAMACHUCO',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130902',
          nombre: 'CHUGAY',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130903',
          nombre: 'COCHORCO',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130904',
          nombre: 'CURGOS',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130905',
          nombre: 'MARCABAL',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130906',
          nombre: 'SANAGORAN',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130907',
          nombre: 'SARIN',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '130908',
          nombre: 'SARTIMBAMBA',
          codigoProvincia: '1309',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131001',
          nombre: 'SANTIAGO DE CHUCO',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131002',
          nombre: 'ANGASMARCA',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131003',
          nombre: 'CACHICADAN',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131004',
          nombre: 'MOLLEBAMBA',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131005',
          nombre: 'MOLLEPATA',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131006',
          nombre: 'QUIRUVILCA',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131007',
          nombre: 'SANTA CRUZ DE CHUCA',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131008',
          nombre: 'SITABAMBA',
          codigoProvincia: '1310',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131101',
          nombre: 'CASCAS',
          codigoProvincia: '1311',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131102',
          nombre: 'LUCMA',
          codigoProvincia: '1311',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131103',
          nombre: 'MARMOT',
          codigoProvincia: '1311',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131104',
          nombre: 'SAYAPULLO',
          codigoProvincia: '1311',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131201',
          nombre: 'VIRU',
          codigoProvincia: '1312',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131202',
          nombre: 'CHAO',
          codigoProvincia: '1312',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '131203',
          nombre: 'GUADALUPITO',
          codigoProvincia: '1312',
          codigoDepartamento: '13'),
      Distrito(
          codigo: '140101',
          nombre: 'CHICLAYO',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140102',
          nombre: 'CHONGOYAPE',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140103',
          nombre: 'ETEN',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140104',
          nombre: 'ETEN PUERTO',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140105',
          nombre: 'JOSE LEONARDO ORTIZ',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140106',
          nombre: 'LA VICTORIA',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140107',
          nombre: 'LAGUNAS',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140108',
          nombre: 'MONSEFU',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140109',
          nombre: 'NUEVA ARICA',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140110',
          nombre: 'OYOTUN',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140111',
          nombre: 'PICSI',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140112',
          nombre: 'PIMENTEL',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140113',
          nombre: 'REQUE',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140114',
          nombre: 'SANTA ROSA',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140115',
          nombre: 'SAÑA',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140116',
          nombre: 'CAYALTI',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140117',
          nombre: 'PATAPO',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140118',
          nombre: 'POMALCA',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140119',
          nombre: 'PUCALA',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140120',
          nombre: 'TUMAN',
          codigoProvincia: '1401',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140201',
          nombre: 'FERREÑAFE',
          codigoProvincia: '1402',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140202',
          nombre: 'CAÑARIS',
          codigoProvincia: '1402',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140203',
          nombre: 'INCAHUASI',
          codigoProvincia: '1402',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140204',
          nombre: 'MANUEL ANTONIO MESONES MURO',
          codigoProvincia: '1402',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140205',
          nombre: 'PITIPO',
          codigoProvincia: '1402',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140206',
          nombre: 'PUEBLO NUEVO',
          codigoProvincia: '1402',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140301',
          nombre: 'LAMBAYEQUE',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140302',
          nombre: 'CHOCHOPE',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140303',
          nombre: 'ILLIMO',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140304',
          nombre: 'JAYANCA',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140305',
          nombre: 'MOCHUMI',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140306',
          nombre: 'MORROPE',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140307',
          nombre: 'MOTUPE',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140308',
          nombre: 'OLMOS',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140309',
          nombre: 'PACORA',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140310',
          nombre: 'SALAS',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140311',
          nombre: 'SAN JOSE',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '140312',
          nombre: 'TUCUME',
          codigoProvincia: '1403',
          codigoDepartamento: '14'),
      Distrito(
          codigo: '150101',
          nombre: 'LIMA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150102',
          nombre: 'ANCON',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150103',
          nombre: 'ATE',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150104',
          nombre: 'BARRANCO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150105',
          nombre: 'BREÑA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150106',
          nombre: 'CARABAYLLO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150107',
          nombre: 'CHACLACAYO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150108',
          nombre: 'CHORRILLOS',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150109',
          nombre: 'CIENEGUILLA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150110',
          nombre: 'COMAS',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150111',
          nombre: 'EL AGUSTINO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150112',
          nombre: 'INDEPENDENCIA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150113',
          nombre: 'JESUS MARIA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150114',
          nombre: 'LA MOLINA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150115',
          nombre: 'LA VICTORIA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150116',
          nombre: 'LINCE',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150117',
          nombre: 'LOS OLIVOS',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150118',
          nombre: 'LURIGANCHO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150119',
          nombre: 'LURIN',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150120',
          nombre: 'MAGDALENA DEL MAR',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150121',
          nombre: 'PUEBLO LIBRE',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150122',
          nombre: 'MIRAFLORES',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150123',
          nombre: 'PACHACAMAC',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150124',
          nombre: 'PUCUSANA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150125',
          nombre: 'PUENTE PIEDRA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150126',
          nombre: 'PUNTA HERMOSA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150127',
          nombre: 'PUNTA NEGRA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150128',
          nombre: 'RIMAC',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150129',
          nombre: 'SAN BARTOLO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150130',
          nombre: 'SAN BORJA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150131',
          nombre: 'SAN ISIDRO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150132',
          nombre: 'SAN JUAN DE LURIGANCHO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150133',
          nombre: 'SAN JUAN DE MIRAFLORES',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150134',
          nombre: 'SAN LUIS',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150135',
          nombre: 'SAN MARTIN DE PORRES',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150136',
          nombre: 'SAN MIGUEL',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150137',
          nombre: 'SANTA ANITA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150138',
          nombre: 'SANTA MARIA DEL MAR',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150139',
          nombre: 'SANTA ROSA',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150140',
          nombre: 'SANTIAGO DE SURCO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150141',
          nombre: 'SURQUILLO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150142',
          nombre: 'VILLA EL SALVADOR',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150143',
          nombre: 'VILLA MARIA DEL TRIUNFO',
          codigoProvincia: '1501',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150201',
          nombre: 'BARRANCA',
          codigoProvincia: '1502',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150202',
          nombre: 'PARAMONGA',
          codigoProvincia: '1502',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150203',
          nombre: 'PATIVILCA',
          codigoProvincia: '1502',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150204',
          nombre: 'SUPE',
          codigoProvincia: '1502',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150205',
          nombre: 'SUPE PUERTO',
          codigoProvincia: '1502',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150301',
          nombre: 'CAJATAMBO',
          codigoProvincia: '1503',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150302',
          nombre: 'COPA',
          codigoProvincia: '1503',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150303',
          nombre: 'GORGOR',
          codigoProvincia: '1503',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150304',
          nombre: 'HUANCAPON',
          codigoProvincia: '1503',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150305',
          nombre: 'MANAS',
          codigoProvincia: '1503',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150401',
          nombre: 'CANTA',
          codigoProvincia: '1504',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150402',
          nombre: 'ARAHUAY',
          codigoProvincia: '1504',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150403',
          nombre: 'HUAMANTANGA',
          codigoProvincia: '1504',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150404',
          nombre: 'HUAROS',
          codigoProvincia: '1504',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150405',
          nombre: 'LACHAQUI',
          codigoProvincia: '1504',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150406',
          nombre: 'SAN BUENAVENTURA',
          codigoProvincia: '1504',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150407',
          nombre: 'SANTA ROSA DE QUIVES',
          codigoProvincia: '1504',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150501',
          nombre: 'SAN VICENTE DE CAÑETE',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150502',
          nombre: 'ASIA',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150503',
          nombre: 'CALANGO',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150504',
          nombre: 'CERRO AZUL',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150505',
          nombre: 'CHILCA',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150506',
          nombre: 'COAYLLO',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150507',
          nombre: 'IMPERIAL',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150508',
          nombre: 'LUNAHUANA',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150509',
          nombre: 'MALA',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150510',
          nombre: 'NUEVO IMPERIAL',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150511',
          nombre: 'PACARAN',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150512',
          nombre: 'QUILMANA',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150513',
          nombre: 'SAN ANTONIO',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150514',
          nombre: 'SAN LUIS',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150515',
          nombre: 'SANTA CRUZ DE FLORES',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150516',
          nombre: 'ZUÑIGA',
          codigoProvincia: '1505',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150601',
          nombre: 'HUARAL',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150602',
          nombre: 'ATAVILLOS ALTO',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150603',
          nombre: 'ATAVILLOS BAJO',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150604',
          nombre: 'AUCALLAMA',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150605',
          nombre: 'CHANCAY',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150606',
          nombre: 'IHUARI',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150607',
          nombre: 'LAMPIAN',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150608',
          nombre: 'PACARAOS',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150609',
          nombre: 'SAN MIGUEL DE ACOS',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150610',
          nombre: 'SANTA CRUZ DE ANDAMARCA',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150611',
          nombre: 'SUMBILCA',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150612',
          nombre: 'VEINTISIETE DE NOVIEMBRE',
          codigoProvincia: '1506',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150701',
          nombre: 'MATUCANA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150702',
          nombre: 'ANTIOQUIA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150703',
          nombre: 'CALLAHUANCA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150704',
          nombre: 'CARAMPOMA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150705',
          nombre: 'CHICLA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150706',
          nombre: 'CUENCA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150707',
          nombre: 'HUACHUPAMPA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150708',
          nombre: 'HUANZA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150709',
          nombre: 'HUAROCHIRI',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150710',
          nombre: 'LAHUAYTAMBO',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150711',
          nombre: 'LANGA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150712',
          nombre: 'SAN PEDRO DE LARAOS',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150713',
          nombre: 'MARIATANA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150714',
          nombre: 'RICARDO PALMA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150715',
          nombre: 'SAN ANDRES DE TUPICOCHA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150716',
          nombre: 'SAN ANTONIO',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150717',
          nombre: 'SAN BARTOLOME',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150718',
          nombre: 'SAN DAMIAN',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150719',
          nombre: 'SAN JUAN DE IRIS',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150720',
          nombre: 'SAN JUAN DE TANTARANCHE',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150721',
          nombre: 'SAN LORENZO DE QUINTI',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150722',
          nombre: 'SAN MATEO',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150723',
          nombre: 'SAN MATEO DE OTAO',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150724',
          nombre: 'SAN PEDRO DE CASTA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150725',
          nombre: 'SAN PEDRO DE HUANCAYRE',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150726',
          nombre: 'SANGALLAYA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150727',
          nombre: 'SANTA CRUZ DE COCACHACRA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150728',
          nombre: 'SANTA EULALIA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150729',
          nombre: 'SANTIAGO DE ANCHUCAYA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150730',
          nombre: 'SANTIAGO DE TUNA',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150731',
          nombre: 'SANTO DOMINGO DE LOS OLLEROS',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150732',
          nombre: 'SURCO',
          codigoProvincia: '1507',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150801',
          nombre: 'HUACHO',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150802',
          nombre: 'AMBAR',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150803',
          nombre: 'CALETA DE CARQUIN',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150804',
          nombre: 'CHECRAS',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150805',
          nombre: 'HUALMAY',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150806',
          nombre: 'HUAURA',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150807',
          nombre: 'LEONCIO PRADO',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150808',
          nombre: 'PACCHO',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150809',
          nombre: 'SANTA LEONOR',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150810',
          nombre: 'SANTA MARIA',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150811',
          nombre: 'SAYAN',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150812',
          nombre: 'VEGUETA',
          codigoProvincia: '1508',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150901',
          nombre: 'OYON',
          codigoProvincia: '1509',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150902',
          nombre: 'ANDAJES',
          codigoProvincia: '1509',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150903',
          nombre: 'CAUJUL',
          codigoProvincia: '1509',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150904',
          nombre: 'COCHAMARCA',
          codigoProvincia: '1509',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150905',
          nombre: 'NAVAN',
          codigoProvincia: '1509',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '150906',
          nombre: 'PACHANGARA',
          codigoProvincia: '1509',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151001',
          nombre: 'YAUYOS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151002',
          nombre: 'ALIS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151003',
          nombre: 'ALLAUCA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151004',
          nombre: 'AYAVIRI',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151005',
          nombre: 'AZANGARO',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151006',
          nombre: 'CACRA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151007',
          nombre: 'CARANIA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151008',
          nombre: 'CATAHUASI',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151009',
          nombre: 'CHOCOS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151010',
          nombre: 'COCHAS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151011',
          nombre: 'COLONIA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151012',
          nombre: 'HONGOS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151013',
          nombre: 'HUAMPARA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151014',
          nombre: 'HUANCAYA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151015',
          nombre: 'HUANGASCAR',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151016',
          nombre: 'HUANTAN',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151017',
          nombre: 'HUAÑEC',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151018',
          nombre: 'LARAOS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151019',
          nombre: 'LINCHA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151020',
          nombre: 'MADEAN',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151021',
          nombre: 'MIRAFLORES',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151022',
          nombre: 'OMAS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151023',
          nombre: 'PUTINZA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151024',
          nombre: 'QUINCHES',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151025',
          nombre: 'QUINOCAY',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151026',
          nombre: 'SAN JOAQUIN',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151027',
          nombre: 'SAN PEDRO DE PILAS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151028',
          nombre: 'TANTA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151029',
          nombre: 'TAURIPAMPA',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151030',
          nombre: 'TOMAS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151031',
          nombre: 'TUPE',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151032',
          nombre: 'VIÑAC',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '151033',
          nombre: 'VITIS',
          codigoProvincia: '1510',
          codigoDepartamento: '15'),
      Distrito(
          codigo: '160101',
          nombre: 'IQUITOS',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160102',
          nombre: 'ALTO NANAY',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160103',
          nombre: 'FERNANDO LORES',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160104',
          nombre: 'INDIANA',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160105',
          nombre: 'LAS AMAZONAS',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160106',
          nombre: 'MAZAN',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160107',
          nombre: 'NAPO',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160108',
          nombre: 'PUNCHANA',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160110',
          nombre: 'TORRES CAUSANA',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160112',
          nombre: 'BELEN',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160113',
          nombre: 'SAN JUAN BAUTISTA',
          codigoProvincia: '1601',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160201',
          nombre: 'YURIMAGUAS',
          codigoProvincia: '1602',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160202',
          nombre: 'BALSAPUERTO',
          codigoProvincia: '1602',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160205',
          nombre: 'JEBEROS',
          codigoProvincia: '1602',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160206',
          nombre: 'LAGUNAS',
          codigoProvincia: '1602',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160210',
          nombre: 'SANTA CRUZ',
          codigoProvincia: '1602',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160211',
          nombre: 'TENIENTE CESAR LOPEZ ROJAS',
          codigoProvincia: '1602',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160301',
          nombre: 'NAUTA',
          codigoProvincia: '1603',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160302',
          nombre: 'PARINARI',
          codigoProvincia: '1603',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160303',
          nombre: 'TIGRE',
          codigoProvincia: '1603',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160304',
          nombre: 'TROMPETEROS',
          codigoProvincia: '1603',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160305',
          nombre: 'URARINAS',
          codigoProvincia: '1603',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160401',
          nombre: 'RAMON CASTILLA',
          codigoProvincia: '1604',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160402',
          nombre: 'PEBAS',
          codigoProvincia: '1604',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160403',
          nombre: 'YAVARI',
          codigoProvincia: '1604',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160404',
          nombre: 'SAN PABLO',
          codigoProvincia: '1604',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160501',
          nombre: 'REQUENA',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160502',
          nombre: 'ALTO TAPICHE',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160503',
          nombre: 'CAPELO',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160504',
          nombre: 'EMILIO SAN MARTIN',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160505',
          nombre: 'MAQUIA',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160506',
          nombre: 'PUINAHUA',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160507',
          nombre: 'SAQUENA',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160508',
          nombre: 'SOPLIN',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160509',
          nombre: 'TAPICHE',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160510',
          nombre: 'JENARO HERRERA',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160511',
          nombre: 'YAQUERANA',
          codigoProvincia: '1605',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160601',
          nombre: 'CONTAMANA',
          codigoProvincia: '1606',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160602',
          nombre: 'INAHUAYA',
          codigoProvincia: '1606',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160603',
          nombre: 'PADRE MARQUEZ',
          codigoProvincia: '1606',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160604',
          nombre: 'PAMPA HERMOSA',
          codigoProvincia: '1606',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160605',
          nombre: 'SARAYACU',
          codigoProvincia: '1606',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160606',
          nombre: 'VARGAS GUERRA',
          codigoProvincia: '1606',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160701',
          nombre: 'BARRANCA',
          codigoProvincia: '1607',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160702',
          nombre: 'CAHUAPANAS',
          codigoProvincia: '1607',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160703',
          nombre: 'MANSERICHE',
          codigoProvincia: '1607',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160704',
          nombre: 'MORONA',
          codigoProvincia: '1607',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160705',
          nombre: 'PASTAZA',
          codigoProvincia: '1607',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160706',
          nombre: 'ANDOAS',
          codigoProvincia: '1607',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160801',
          nombre: 'PUTUMAYO',
          codigoProvincia: '1608',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160802',
          nombre: 'ROSA PANDURO',
          codigoProvincia: '1608',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160803',
          nombre: 'TENIENTE MANUEL CLAVERO',
          codigoProvincia: '1608',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '160804',
          nombre: 'YAGUAS',
          codigoProvincia: '1608',
          codigoDepartamento: '16'),
      Distrito(
          codigo: '170101',
          nombre: 'TAMBOPATA',
          codigoProvincia: '1701',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170102',
          nombre: 'INAMBARI',
          codigoProvincia: '1701',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170103',
          nombre: 'LAS PIEDRAS',
          codigoProvincia: '1701',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170104',
          nombre: 'LABERINTO',
          codigoProvincia: '1701',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170201',
          nombre: 'MANU',
          codigoProvincia: '1702',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170202',
          nombre: 'FITZCARRALD',
          codigoProvincia: '1702',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170203',
          nombre: 'MADRE DE DIOS',
          codigoProvincia: '1702',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170204',
          nombre: 'HUEPETUHE',
          codigoProvincia: '1702',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170301',
          nombre: 'IÑAPARI',
          codigoProvincia: '1703',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170302',
          nombre: 'IBERIA',
          codigoProvincia: '1703',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '170303',
          nombre: 'TAHUAMANU',
          codigoProvincia: '1703',
          codigoDepartamento: '17'),
      Distrito(
          codigo: '180101',
          nombre: 'MOQUEGUA',
          codigoProvincia: '1801',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180102',
          nombre: 'CARUMAS',
          codigoProvincia: '1801',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180103',
          nombre: 'CUCHUMBAYA',
          codigoProvincia: '1801',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180104',
          nombre: 'SAMEGUA',
          codigoProvincia: '1801',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180105',
          nombre: 'SAN CRISTOBAL',
          codigoProvincia: '1801',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180106',
          nombre: 'TORATA',
          codigoProvincia: '1801',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180107',
          nombre: 'SAN ANTONIO',
          codigoProvincia: '1801',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180201',
          nombre: 'OMATE',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180202',
          nombre: 'CHOJATA',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180203',
          nombre: 'COALAQUE',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180204',
          nombre: 'ICHUÑA',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180205',
          nombre: 'LA CAPILLA',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180206',
          nombre: 'LLOQUE',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180207',
          nombre: 'MATALAQUE',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180208',
          nombre: 'PUQUINA',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180209',
          nombre: 'QUINISTAQUILLAS',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180210',
          nombre: 'UBINAS',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180211',
          nombre: 'YUNGA',
          codigoProvincia: '1802',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180301',
          nombre: 'ILO',
          codigoProvincia: '1803',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180302',
          nombre: 'EL ALGARROBAL',
          codigoProvincia: '1803',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '180303',
          nombre: 'PACOCHA',
          codigoProvincia: '1803',
          codigoDepartamento: '18'),
      Distrito(
          codigo: '190101',
          nombre: 'CHAUPIMARCA',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190102',
          nombre: 'HUACHON',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190103',
          nombre: 'HUARIACA',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190104',
          nombre: 'HUAYLLAY',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190105',
          nombre: 'NINACACA',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190106',
          nombre: 'PALLANCHACRA',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190107',
          nombre: 'PAUCARTAMBO',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190108',
          nombre: 'SAN FRANCISCO DE ASIS DE YARUSYACAN',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190109',
          nombre: 'SIMON BOLIVAR',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190110',
          nombre: 'TICLACAYAN',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190111',
          nombre: 'TINYAHUARCO',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190112',
          nombre: 'VICCO',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190113',
          nombre: 'YANACANCHA',
          codigoProvincia: '1901',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190201',
          nombre: 'YANAHUANCA',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190202',
          nombre: 'CHACAYAN',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190203',
          nombre: 'GOYLLARISQUIZGA',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190204',
          nombre: 'PAUCAR',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190205',
          nombre: 'SAN PEDRO DE PILLAO',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190206',
          nombre: 'SANTA ANA DE TUSI',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190207',
          nombre: 'TAPUC',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190208',
          nombre: 'VILCABAMBA',
          codigoProvincia: '1902',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190301',
          nombre: 'OXAPAMPA',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190302',
          nombre: 'CHONTABAMBA',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190303',
          nombre: 'HUANCABAMBA',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190304',
          nombre: 'PALCAZU',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190305',
          nombre: 'POZUZO',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190306',
          nombre: 'PUERTO BERMUDEZ',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190307',
          nombre: 'VILLA RICA',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '190308',
          nombre: 'CONSTITUCION',
          codigoProvincia: '1903',
          codigoDepartamento: '19'),
      Distrito(
          codigo: '200101',
          nombre: 'PIURA',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200104',
          nombre: 'CASTILLA',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200105',
          nombre: 'CATACAOS',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200107',
          nombre: 'CURA MORI',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200108',
          nombre: 'EL TALLAN',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200109',
          nombre: 'LA ARENA',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200110',
          nombre: 'LA UNION',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200111',
          nombre: 'LAS LOMAS',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200114',
          nombre: 'TAMBO GRANDE',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200115',
          nombre: 'VEINTISEIS DE OCTUBRE',
          codigoProvincia: '2001',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200201',
          nombre: 'AYABACA',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200202',
          nombre: 'FRIAS',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200203',
          nombre: 'JILILI',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200204',
          nombre: 'LAGUNAS',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200205',
          nombre: 'MONTERO',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200206',
          nombre: 'PACAIPAMPA',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200207',
          nombre: 'PAIMAS',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200208',
          nombre: 'SAPILLICA',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200209',
          nombre: 'SICCHEZ',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200210',
          nombre: 'SUYO',
          codigoProvincia: '2002',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200301',
          nombre: 'HUANCABAMBA',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200302',
          nombre: 'CANCHAQUE',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200303',
          nombre: 'EL CARMEN DE LA FRONTERA',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200304',
          nombre: 'HUARMACA',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200305',
          nombre: 'LALAQUIZ',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200306',
          nombre: 'SAN MIGUEL DE EL FAIQUE',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200307',
          nombre: 'SONDOR',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200308',
          nombre: 'SONDORILLO',
          codigoProvincia: '2003',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200401',
          nombre: 'CHULUCANAS',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200402',
          nombre: 'BUENOS AIRES',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200403',
          nombre: 'CHALACO',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200404',
          nombre: 'LA MATANZA',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200405',
          nombre: 'MORROPON',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200406',
          nombre: 'SALITRAL',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200407',
          nombre: 'SAN JUAN DE BIGOTE',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200408',
          nombre: 'SANTA CATALINA DE MOSSA',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200409',
          nombre: 'SANTO DOMINGO',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200410',
          nombre: 'YAMANGO',
          codigoProvincia: '2004',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200501',
          nombre: 'PAITA',
          codigoProvincia: '2005',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200502',
          nombre: 'AMOTAPE',
          codigoProvincia: '2005',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200503',
          nombre: 'ARENAL',
          codigoProvincia: '2005',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200504',
          nombre: 'COLAN',
          codigoProvincia: '2005',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200505',
          nombre: 'LA HUACA',
          codigoProvincia: '2005',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200506',
          nombre: 'TAMARINDO',
          codigoProvincia: '2005',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200507',
          nombre: 'VICHAYAL',
          codigoProvincia: '2005',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200601',
          nombre: 'SULLANA',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200602',
          nombre: 'BELLAVISTA',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200603',
          nombre: 'IGNACIO ESCUDERO',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200604',
          nombre: 'LANCONES',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200605',
          nombre: 'MARCAVELICA',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200606',
          nombre: 'MIGUEL CHECA',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200607',
          nombre: 'QUERECOTILLO',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200608',
          nombre: 'SALITRAL',
          codigoProvincia: '2006',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200701',
          nombre: 'PARIÑAS',
          codigoProvincia: '2007',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200702',
          nombre: 'EL ALTO',
          codigoProvincia: '2007',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200703',
          nombre: 'LA BREA',
          codigoProvincia: '2007',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200704',
          nombre: 'LOBITOS',
          codigoProvincia: '2007',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200705',
          nombre: 'LOS ORGANOS',
          codigoProvincia: '2007',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200706',
          nombre: 'MANCORA',
          codigoProvincia: '2007',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200801',
          nombre: 'SECHURA',
          codigoProvincia: '2008',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200802',
          nombre: 'BELLAVISTA DE LA UNION',
          codigoProvincia: '2008',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200803',
          nombre: 'BERNAL',
          codigoProvincia: '2008',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200804',
          nombre: 'CRISTO NOS VALGA',
          codigoProvincia: '2008',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200805',
          nombre: 'VICE',
          codigoProvincia: '2008',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '200806',
          nombre: 'RINCONADA LLICUAR',
          codigoProvincia: '2008',
          codigoDepartamento: '20'),
      Distrito(
          codigo: '210101',
          nombre: 'PUNO',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210102',
          nombre: 'ACORA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210103',
          nombre: 'AMANTANI',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210104',
          nombre: 'ATUNCOLLA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210105',
          nombre: 'CAPACHICA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210106',
          nombre: 'CHUCUITO',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210107',
          nombre: 'COATA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210108',
          nombre: 'HUATA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210109',
          nombre: 'MAÑAZO',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210110',
          nombre: 'PAUCARCOLLA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210111',
          nombre: 'PICHACANI',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210112',
          nombre: 'PLATERIA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210113',
          nombre: 'SAN ANTONIO',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210114',
          nombre: 'TIQUILLACA',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210115',
          nombre: 'VILQUE',
          codigoProvincia: '2101',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210201',
          nombre: 'AZANGARO',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210202',
          nombre: 'ACHAYA',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210203',
          nombre: 'ARAPA',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210204',
          nombre: 'ASILLO',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210205',
          nombre: 'CAMINACA',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210206',
          nombre: 'CHUPA',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210207',
          nombre: 'JOSE DOMINGO CHOQUEHUANCA',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210208',
          nombre: 'MUÑANI',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210209',
          nombre: 'POTONI',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210210',
          nombre: 'SAMAN',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210211',
          nombre: 'SAN ANTON',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210212',
          nombre: 'SAN JOSE',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210213',
          nombre: 'SAN JUAN DE SALINAS',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210214',
          nombre: 'SANTIAGO DE PUPUJA',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210215',
          nombre: 'TIRAPATA',
          codigoProvincia: '2102',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210301',
          nombre: 'MACUSANI',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210302',
          nombre: 'AJOYANI',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210303',
          nombre: 'AYAPATA',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210304',
          nombre: 'COASA',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210305',
          nombre: 'CORANI',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210306',
          nombre: 'CRUCERO',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210307',
          nombre: 'ITUATA',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210308',
          nombre: 'OLLACHEA',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210309',
          nombre: 'SAN GABAN',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210310',
          nombre: 'USICAYOS',
          codigoProvincia: '2103',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210401',
          nombre: 'JULI',
          codigoProvincia: '2104',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210402',
          nombre: 'DESAGUADERO',
          codigoProvincia: '2104',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210403',
          nombre: 'HUACULLANI',
          codigoProvincia: '2104',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210404',
          nombre: 'KELLUYO',
          codigoProvincia: '2104',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210405',
          nombre: 'PISACOMA',
          codigoProvincia: '2104',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210406',
          nombre: 'POMATA',
          codigoProvincia: '2104',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210407',
          nombre: 'ZEPITA',
          codigoProvincia: '2104',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210501',
          nombre: 'ILAVE',
          codigoProvincia: '2105',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210502',
          nombre: 'CAPAZO',
          codigoProvincia: '2105',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210503',
          nombre: 'PILCUYO',
          codigoProvincia: '2105',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210504',
          nombre: 'SANTA ROSA',
          codigoProvincia: '2105',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210505',
          nombre: 'CONDURIRI',
          codigoProvincia: '2105',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210601',
          nombre: 'HUANCANE',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210602',
          nombre: 'COJATA',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210603',
          nombre: 'HUATASANI',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210604',
          nombre: 'INCHUPALLA',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210605',
          nombre: 'PUSI',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210606',
          nombre: 'ROSASPATA',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210607',
          nombre: 'TARACO',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210608',
          nombre: 'VILQUE CHICO',
          codigoProvincia: '2106',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210701',
          nombre: 'LAMPA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210702',
          nombre: 'CABANILLA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210703',
          nombre: 'CALAPUJA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210704',
          nombre: 'NICASIO',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210705',
          nombre: 'OCUVIRI',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210706',
          nombre: 'PALCA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210707',
          nombre: 'PARATIA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210708',
          nombre: 'PUCARA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210709',
          nombre: 'SANTA LUCIA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210710',
          nombre: 'VILAVILA',
          codigoProvincia: '2107',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210801',
          nombre: 'AYAVIRI',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210802',
          nombre: 'ANTAUTA',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210803',
          nombre: 'CUPI',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210804',
          nombre: 'LLALLI',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210805',
          nombre: 'MACARI',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210806',
          nombre: 'NUÑOA',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210807',
          nombre: 'ORURILLO',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210808',
          nombre: 'SANTA ROSA',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210809',
          nombre: 'UMACHIRI',
          codigoProvincia: '2108',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210901',
          nombre: 'MOHO',
          codigoProvincia: '2109',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210902',
          nombre: 'CONIMA',
          codigoProvincia: '2109',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210903',
          nombre: 'HUAYRAPATA',
          codigoProvincia: '2109',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '210904',
          nombre: 'TILALI',
          codigoProvincia: '2109',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211001',
          nombre: 'PUTINA',
          codigoProvincia: '2110',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211002',
          nombre: 'ANANEA',
          codigoProvincia: '2110',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211003',
          nombre: 'PEDRO VILCA APAZA',
          codigoProvincia: '2110',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211004',
          nombre: 'QUILCAPUNCU',
          codigoProvincia: '2110',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211005',
          nombre: 'SINA',
          codigoProvincia: '2110',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211101',
          nombre: 'JULIACA',
          codigoProvincia: '2111',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211102',
          nombre: 'CABANA',
          codigoProvincia: '2111',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211103',
          nombre: 'CABANILLAS',
          codigoProvincia: '2111',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211104',
          nombre: 'CARACOTO',
          codigoProvincia: '2111',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211105',
          nombre: 'SAN MIGUEL',
          codigoProvincia: '2111',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211201',
          nombre: 'SANDIA',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211202',
          nombre: 'CUYOCUYO',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211203',
          nombre: 'LIMBANI',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211204',
          nombre: 'PATAMBUCO',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211205',
          nombre: 'PHARA',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211206',
          nombre: 'QUIACA',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211207',
          nombre: 'SAN JUAN DEL ORO',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211208',
          nombre: 'YANAHUAYA',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211209',
          nombre: 'ALTO INAMBARI',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211210',
          nombre: 'SAN PEDRO DE PUTINA PUNCO',
          codigoProvincia: '2112',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211301',
          nombre: 'YUNGUYO',
          codigoProvincia: '2113',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211302',
          nombre: 'ANAPIA',
          codigoProvincia: '2113',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211303',
          nombre: 'COPANI',
          codigoProvincia: '2113',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211304',
          nombre: 'CUTURAPI',
          codigoProvincia: '2113',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211305',
          nombre: 'OLLARAYA',
          codigoProvincia: '2113',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211306',
          nombre: 'TINICACHI',
          codigoProvincia: '2113',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '211307',
          nombre: 'UNICACHI',
          codigoProvincia: '2113',
          codigoDepartamento: '21'),
      Distrito(
          codigo: '220101',
          nombre: 'MOYOBAMBA',
          codigoProvincia: '2201',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220102',
          nombre: 'CALZADA',
          codigoProvincia: '2201',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220103',
          nombre: 'HABANA',
          codigoProvincia: '2201',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220104',
          nombre: 'JEPELACIO',
          codigoProvincia: '2201',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220105',
          nombre: 'SORITOR',
          codigoProvincia: '2201',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220106',
          nombre: 'YANTALO',
          codigoProvincia: '2201',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220201',
          nombre: 'BELLAVISTA',
          codigoProvincia: '2202',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220202',
          nombre: 'ALTO BIAVO',
          codigoProvincia: '2202',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220203',
          nombre: 'BAJO BIAVO',
          codigoProvincia: '2202',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220204',
          nombre: 'HUALLAGA',
          codigoProvincia: '2202',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220205',
          nombre: 'SAN PABLO',
          codigoProvincia: '2202',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220206',
          nombre: 'SAN RAFAEL',
          codigoProvincia: '2202',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220301',
          nombre: 'SAN JOSE DE SISA',
          codigoProvincia: '2203',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220302',
          nombre: 'AGUA BLANCA',
          codigoProvincia: '2203',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220303',
          nombre: 'SAN MARTIN',
          codigoProvincia: '2203',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220304',
          nombre: 'SANTA ROSA',
          codigoProvincia: '2203',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220305',
          nombre: 'SHATOJA',
          codigoProvincia: '2203',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220401',
          nombre: 'SAPOSOA',
          codigoProvincia: '2204',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220402',
          nombre: 'ALTO SAPOSOA',
          codigoProvincia: '2204',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220403',
          nombre: 'EL ESLABON',
          codigoProvincia: '2204',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220404',
          nombre: 'PISCOYACU',
          codigoProvincia: '2204',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220405',
          nombre: 'SACANCHE',
          codigoProvincia: '2204',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220406',
          nombre: 'TINGO DE SAPOSOA',
          codigoProvincia: '2204',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220501',
          nombre: 'LAMAS',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220502',
          nombre: 'ALONSO DE ALVARADO',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220503',
          nombre: 'BARRANQUITA',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220504',
          nombre: 'CAYNARACHI',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220505',
          nombre: 'CUÑUMBUQUI',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220506',
          nombre: 'PINTO RECODO',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220507',
          nombre: 'RUMISAPA',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220508',
          nombre: 'SAN ROQUE DE CUMBAZA',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220509',
          nombre: 'SHANAO',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220510',
          nombre: 'TABALOSOS',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220511',
          nombre: 'ZAPATERO',
          codigoProvincia: '2205',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220601',
          nombre: 'JUANJUI',
          codigoProvincia: '2206',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220602',
          nombre: 'CAMPANILLA',
          codigoProvincia: '2206',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220603',
          nombre: 'HUICUNGO',
          codigoProvincia: '2206',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220604',
          nombre: 'PACHIZA',
          codigoProvincia: '2206',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220605',
          nombre: 'PAJARILLO',
          codigoProvincia: '2206',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220701',
          nombre: 'PICOTA',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220702',
          nombre: 'BUENOS AIRES',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220703',
          nombre: 'CASPISAPA',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220704',
          nombre: 'PILLUANA',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220705',
          nombre: 'PUCACACA',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220706',
          nombre: 'SAN CRISTOBAL',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220707',
          nombre: 'SAN HILARION',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220708',
          nombre: 'SHAMBOYACU',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220709',
          nombre: 'TINGO DE PONASA',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220710',
          nombre: 'TRES UNIDOS',
          codigoProvincia: '2207',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220801',
          nombre: 'RIOJA',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220802',
          nombre: 'AWAJUN',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220803',
          nombre: 'ELIAS SOPLIN VARGAS',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220804',
          nombre: 'NUEVA CAJAMARCA',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220805',
          nombre: 'PARDO MIGUEL',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220806',
          nombre: 'POSIC',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220807',
          nombre: 'SAN FERNANDO',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220808',
          nombre: 'YORONGOS',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220809',
          nombre: 'YURACYACU',
          codigoProvincia: '2208',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220901',
          nombre: 'TARAPOTO',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220902',
          nombre: 'ALBERTO LEVEAU',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220903',
          nombre: 'CACATACHI',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220904',
          nombre: 'CHAZUTA',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220905',
          nombre: 'CHIPURANA',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220906',
          nombre: 'EL PORVENIR',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220907',
          nombre: 'HUIMBAYOC',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220908',
          nombre: 'JUAN GUERRA',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220909',
          nombre: 'LA BANDA DE SHILCAYO',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220910',
          nombre: 'MORALES',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220911',
          nombre: 'PAPAPLAYA',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220912',
          nombre: 'SAN ANTONIO',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220913',
          nombre: 'SAUCE',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '220914',
          nombre: 'SHAPAJA',
          codigoProvincia: '2209',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '221001',
          nombre: 'TOCACHE',
          codigoProvincia: '2210',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '221002',
          nombre: 'NUEVO PROGRESO',
          codigoProvincia: '2210',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '221003',
          nombre: 'POLVORA',
          codigoProvincia: '2210',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '221004',
          nombre: 'SHUNTE',
          codigoProvincia: '2210',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '221005',
          nombre: 'UCHIZA',
          codigoProvincia: '2210',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '221006',
          nombre: 'SANTA LUCIA',
          codigoProvincia: '2210',
          codigoDepartamento: '22'),
      Distrito(
          codigo: '230101',
          nombre: 'TACNA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230102',
          nombre: 'ALTO DE LA ALIANZA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230103',
          nombre: 'CALANA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230104',
          nombre: 'CIUDAD NUEVA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230105',
          nombre: 'INCLAN',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230106',
          nombre: 'PACHIA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230107',
          nombre: 'PALCA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230108',
          nombre: 'POCOLLAY',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230109',
          nombre: 'SAMA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230110',
          nombre: 'CORONEL GREGORIO ALBARRACIN LANCHIPA',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230111',
          nombre: 'LA YARADA LOS PALOS',
          codigoProvincia: '2301',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230201',
          nombre: 'CANDARAVE',
          codigoProvincia: '2302',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230202',
          nombre: 'CAIRANI',
          codigoProvincia: '2302',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230203',
          nombre: 'CAMILACA',
          codigoProvincia: '2302',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230204',
          nombre: 'CURIBAYA',
          codigoProvincia: '2302',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230205',
          nombre: 'HUANUARA',
          codigoProvincia: '2302',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230206',
          nombre: 'QUILAHUANI',
          codigoProvincia: '2302',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230301',
          nombre: 'LOCUMBA',
          codigoProvincia: '2303',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230302',
          nombre: 'ILABAYA',
          codigoProvincia: '2303',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230303',
          nombre: 'ITE',
          codigoProvincia: '2303',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230401',
          nombre: 'TARATA',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230402',
          nombre: 'HEROES ALBARRACIN',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230403',
          nombre: 'ESTIQUE',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230404',
          nombre: 'ESTIQUE-PAMPA',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230405',
          nombre: 'SITAJARA',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230406',
          nombre: 'SUSAPAYA',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230407',
          nombre: 'TARUCACHI',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '230408',
          nombre: 'TICACO',
          codigoProvincia: '2304',
          codigoDepartamento: '23'),
      Distrito(
          codigo: '240101',
          nombre: 'TUMBES',
          codigoProvincia: '2401',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240102',
          nombre: 'CORRALES',
          codigoProvincia: '2401',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240103',
          nombre: 'LA CRUZ',
          codigoProvincia: '2401',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240104',
          nombre: 'PAMPAS DE HOSPITAL',
          codigoProvincia: '2401',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240105',
          nombre: 'SAN JACINTO',
          codigoProvincia: '2401',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240106',
          nombre: 'SAN JUAN DE LA VIRGEN',
          codigoProvincia: '2401',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240201',
          nombre: 'ZORRITOS',
          codigoProvincia: '2402',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240202',
          nombre: 'CASITAS',
          codigoProvincia: '2402',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240203',
          nombre: 'CANOAS DE PUNTA SAL',
          codigoProvincia: '2402',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240301',
          nombre: 'ZARUMILLA',
          codigoProvincia: '2403',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240302',
          nombre: 'AGUAS VERDES',
          codigoProvincia: '2403',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240303',
          nombre: 'MATAPALO',
          codigoProvincia: '2403',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '240304',
          nombre: 'PAPAYAL',
          codigoProvincia: '2403',
          codigoDepartamento: '24'),
      Distrito(
          codigo: '250101',
          nombre: 'CALLERIA',
          codigoProvincia: '2501',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250102',
          nombre: 'CAMPOVERDE',
          codigoProvincia: '2501',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250103',
          nombre: 'IPARIA',
          codigoProvincia: '2501',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250104',
          nombre: 'MASISEA',
          codigoProvincia: '2501',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250105',
          nombre: 'YARINACOCHA',
          codigoProvincia: '2501',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250106',
          nombre: 'NUEVA REQUENA',
          codigoProvincia: '2501',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250107',
          nombre: 'MANANTAY',
          codigoProvincia: '2501',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250201',
          nombre: 'RAIMONDI',
          codigoProvincia: '2502',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250202',
          nombre: 'SEPAHUA',
          codigoProvincia: '2502',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250203',
          nombre: 'TAHUANIA',
          codigoProvincia: '2502',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250204',
          nombre: 'YURUA',
          codigoProvincia: '2502',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250301',
          nombre: 'PADRE ABAD',
          codigoProvincia: '2503',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250302',
          nombre: 'IRAZOLA',
          codigoProvincia: '2503',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250303',
          nombre: 'CURIMANA',
          codigoProvincia: '2503',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250304',
          nombre: 'NESHUYA',
          codigoProvincia: '2503',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250305',
          nombre: 'ALEXANDER VON HUMBOLDT',
          codigoProvincia: '2503',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250306',
          nombre: 'HUIPOCA',
          codigoProvincia: '2503',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250307',
          nombre: 'BOQUERON',
          codigoProvincia: '2503',
          codigoDepartamento: '25'),
      Distrito(
          codigo: '250401',
          nombre: 'PURUS',
          codigoProvincia: '2504',
          codigoDepartamento: '25')
    ];
  }
}
