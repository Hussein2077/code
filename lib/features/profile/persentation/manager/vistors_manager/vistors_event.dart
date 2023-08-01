

abstract class VistorsEvent  {
  const VistorsEvent();

  // @override
  // List<Object> get props => [];
}
class GetVistors extends VistorsEvent{
  
}
class GetMoreVistors extends VistorsEvent{
  final String page ; 
 const GetMoreVistors({required this.page});

}
