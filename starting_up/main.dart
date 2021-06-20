void main() {
  var minhaClasse = MinhaClasse();
  printHelloWorld(message: minhaClasse.message);
}

void printHelloWorld({required String message}) {
  print(message.replaceAll("CERTO", "GOSTOSO"));
}

class MinhaClasse {
  var message = "DEU CERTO!";
}
