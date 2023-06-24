import "package:dart_amqp/dart_amqp.dart";



class Rabbit{
  Future<dynamic> fan() async {


  ConnectionSettings settings = ConnectionSettings(
      host: "51.105.45.183",
      port: 5672,
      authProvider: PlainAuthenticator("user", "pass")
  );


  Client client = Client(settings:settings);

  Channel channel = await client.channel();
  Exchange echange=await channel.exchange("hello", ExchangeType.FANOUT);

  Queue queue = await echange.channel.queue("hello");
  Consumer consumer = await queue.consume();
  String s="";
  consumer.listen((AmqpMessage message) {
  // Get the payload as a string
  s= message.payloadAsString;

  //message.reply("world");

  }

  );
  print(s);
  return "s";
}






}


