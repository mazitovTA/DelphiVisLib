library vision_lib;

uses
  SimpleShareMem,
  Classes,
  Info in 'Info.pas',
  Blocks in 'Blocks.pas';

{$R *.res}

  //Эта функция возвращает адрес структуры DllInfo
function  GetEntry:Pointer;
begin
  Result:=@DllInfo;
end;

exports
  GetEntry name 'GetEntry',         //Функция получения адреса структуры DllInfo
  CreateObject name 'CreateObject'; //Функция создания объекта

begin
end.
