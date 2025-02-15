// Enumeració de GetBuilder's per a la seva actualització.
// createdAt: 24/07/18 dj. JIQ

// Enumeració de widgets a actualitzar.
enum WidgetKey implements Comparable<WidgetKey> {
// Widget principal d'una pàgina.
  scaffold(pId: "scaffold", pName: 'scaffold'),
  // Widget de la barra superior d'una pàgina.
  appBar(pId: "appBar", pName: 'appBar'),
  // Widget de la barra superior de progrés.
  appBarProgress(pId: "appBarProgress", pName: 'appBarProgress'),
  // Widget del cos d'una pàgina.
  pageBody(pId: "pageBody", pName: 'pageBody'),
  // Widget de la barra inferior d'una pàgina.
  bottomBar(pId: "bottomBar", pName: 'bottomBar'),
  // Widget del menú lateral d'una pàgina.
  drawer(pId: "drawer", pName: 'drawer'),
  // Widget del botó flotant d'una pàgina.
  floatingActionButton(pId: "floatingActionButton", pName: 'floatingActionButton'),
  // Widget de la barra inferior d'una pàgina que mostra missatges breus.
  snackbar(pId: "snackbar", pName: 'snackbar'),
  // Widget de diàleg modal que mostra informació o demana una decisió a l'usuari.
  dialog(pId: "dialog", pName: 'dialog'),
  // Widget que s'obre des de la part inferior de la pantalla i mostra informació o opcions addicionals.
  bottomSheet(pId: "bottomSheet", pName: 'bottomSheet'),
  // Widget que mostra informació en un format compacte i visualment atractiu.
  card(pId: "card", pName: 'card'),
  // Widget que mostra informació en una fila amb un ícone, un títol i una subtítol opcionals.
  listTile(pId: "listTile", pName: 'listTile'),
  // Widget que representa una etiqueta o un element seleccionable en una llista o un formulari.
  chip(pId: "chip", pName: 'chip'),
  // Widget que permet a l'usuari navegar entre diferents seccions o pàgines d'una aplicació.
  tabBar(pId: "tabBar", pName: 'tabBar'),
  // Widget que mostra el contingut associat a una pestanya seleccionada en un TabBar.
  tabBarView(pId: "tabBarView", pName: 'tabBarView'),

  // Índex de l'entrada a partir de la qual fer widgets custom.
  custom(pId: "custom", pName: 'custom');

  final String _idx;
  final String _name;

  const WidgetKey({required String pId, required String pName})
      : _idx = pId,
        _name = pName;

  @override
  String toString() => "WidgetKey[$_idx: '$_name']";

  String get idx => _idx;
  String get name => _name;

  @override
  int compareTo(WidgetKey other) => _idx.compareTo(other._idx);
}
