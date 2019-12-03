//ErrorEvent('1!!!', msError, VisualObject);
unit Blocks;

interface

uses Windows, Classes, DataTypes, SysUtils, RunObjts, uExtMath, IntArrays;

type
  pPointer        = ^Pointer;
  TConversionType = (BGR_2_RGB,
                     RGBA_2_RGB,
                     RGB_2_BGR,
                     RGB_2_GRAY,
                     RGB_2_HSV);

  TIMSHOW = class(TRunObject)
  public
    windowName:    String;
    delay:         Integer;
    frame:         Pointer;

    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TIMREAD = class(TRunObject)
  public
    frame:         Pointer;
    sourceName:    String;
    code:          Integer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TFRAMESOURCE = class(TRunObject)
  public
    sourceName:    String;
    source:        Pointer;
    frame:         Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TCOLORCONVERT = class(TRunObject)
  public
    src:           Pointer;
    dst:           Pointer;
    code:          Integer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISEAND = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    dst:           Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISEOR = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    dst:           Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISENO = class(TRunObject)
  public
    src:           Pointer;
    dst:           Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISEXOR = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    dst:           Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;


  TperElementAddWeighted = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    alpha:         Double;
    beta:          Double;
    dst:           Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TperElementDIV = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    scale:         Double;
    dst:           Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TperElementMUL = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    scale:         Double;
    dst:           Pointer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;


  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////

var
  createHandledWindow : function(windowName: AnsiString):Pointer; cdecl;
  getWindowHandle : function(windowName: AnsiString):Pointer; cdecl;
  releaseSimMat : function(sourse: pPointer):Integer; cdecl;

  openImage : function(frame: pPointer; windowName: AnsiString; code:Integer):Integer; cdecl;
  showFrame : function(sourse: Pointer; delay: Integer; windowName: AnsiString):Integer; cdecl;
  openVideoSource : function(sourse: pPointer; windowName: AnsiString):Integer; cdecl;
  retrieveImage : function(sourse: Pointer; frame: pPointer):Integer; cdecl;
  releaseSourse : function(sourse: Pointer):Integer; cdecl;
  destroyWindowByName : function(windowName: AnsiString):Integer; cdecl;
  destroyAllWindows : function():Integer; cdecl;

  bitwiseAND : function(src1, src2 : Pointer; dst: pPointer):Integer; cdecl;
  bitwiseOR  : function(src1, src2 : Pointer; dst: pPointer):Integer; cdecl;
  bitwiseNO  : function(src1 : Pointer; dst: pPointer):Integer; cdecl;
  bitwiseXOR : function(src1, src2 : Pointer; dst: pPointer):Integer; cdecl;

  perElementAddWeighted : function(src1 : Pointer; alpha : Double; src2: Pointer;  beta : Double;  dst : pPointer):Integer; cdecl;
  perElementDIV : function(scale : Double; src1 : Pointer; src2 : Pointer;  dst : pPointer):Integer; cdecl;
  perElementMUL : function(scale : Double; src1 : Pointer; src2 : Pointer;  dst : pPointer):Integer; cdecl;

  convertColor : function(src1: Pointer; dst: pPointer; code: Integer):Integer; cdecl;

implementation

uses math;
////////////////////////////////////////////////////////////////////////////
////////////////////////////    TFRAMESOURCE   /////////////////////////////
////////////////////////////////////////////////////////////////////////////


function    TFRAMESOURCE.GetParamID;
begin
  Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
   if StrEqu(ParamName,'source') then begin
      Result:=NativeInt(@sourceName);
      DataType:=dtString;
    end
  end
end;

function TFRAMESOURCE.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
begin
   Result:=0;
  case Action of
     i_GetCount:    begin
                      cY[0] := 1;
                   end;
    i_GetInit:     begin
                     Result:=1;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TFRAMESOURCE.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
    f_InitState:
       begin
          res := openVideoSource(@source, sourceName);
          //notReady := 1;//************************** обработать res
          Result:=0;
       end;

    f_GoodStep:
       begin
           if res = 0 then
           begin
               res := retrieveImage(source, @frame);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=frame;
               end
               else
               begin
                  pPointer(@Y[0].Arr^[0])^:=nil;
               end;
           end
           else
           begin
              pPointer(@Y[0].Arr^[0])^:=nil;
           end;

       end;

    f_Stop:
       begin
           releaseSimMat(@frame);
           releaseSourse(source);
       end;
 end;
 end;

///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TIMREAD   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////


function    TIMREAD.GetParamID;
begin
  Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'source') then begin
      Result:=NativeInt(@sourceName);
      DataType:=dtString;
    end
  end
end;


function TIMREAD.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 1;
                   end;
    i_GetInit:     begin
                     Result:=1;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TIMREAD.RunFunc;
var res: Integer;
begin
 Result:=0;
 case Action of
    f_InitState:
       begin
          Result:=0;
       end;

    f_GoodStep:
       begin
           res := openImage(@frame, sourceName, code);
           if res = 0 then
           begin
              pPointer(@Y[0].Arr^[0])^:=frame;
           end
           else
           begin
             pPointer(@Y[0].Arr^[0])^:=nil;
           end;
       end;

    f_Stop:
       begin
           releaseSimMat(@frame);
       end;
   end;
 end;
 ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TIMSHOW   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TIMSHOW.GetParamID;
begin
  Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'windowName') then begin
      Result:=NativeInt(@windowName);
      DataType:=dtString;
    end
    else
    if StrEqu(ParamName,'delay') then begin
      Result:=NativeInt(@delay);
      DataType:=dtInteger;
    end;
  end
end;

function   TIMSHOW.RunFunc;
var res: Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          createHandledWindow(windowName);
          Result:=0;
       end;

    f_GoodStep:
       begin
           frame := pPointer(@U[0].Arr^[0])^;
           res := showFrame(frame, delay, windowName);
       end;

    f_Stop:
       begin
          destroyWindowByName(windowName);
       end;
   end;
 end;
///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TCOLORCONVERT   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TCOLORCONVERT.GetParamID;
begin
  Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
end;

function TCOLORCONVERT.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;

begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 1;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TCOLORCONVERT.RunFunc;
var res :Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          src := pPointer(@U[0].Arr^[0])^;
           Case code of
              integer(BGR_2_RGB):
                 res := convertColor(src, @dst, 4);
              integer(RGBA_2_RGB):
                 res := convertColor(src, @dst, 1);
              integer(RGB_2_BGR):
                 res := convertColor(src, @dst, 4);
              integer(RGB_2_GRAY):
                 res := convertColor(src, @dst, 7);
              integer(RGB_2_HSV):
                 res := convertColor(src, @dst, 41);
           End;
           pPointer(@Y[0].Arr^[0])^:=dst;
       end;
    f_Stop:
       begin
           releaseSimMat(@dst);
       end;
   end;
 end;


 //**************************************************

 ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TBITWISEAND   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TBITWISEAND.GetParamID;
begin
  Result:=-1;
end;

function TBITWISEAND.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;

begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 0;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TBITWISEAND.RunFunc;
var res: Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          src1 := pPointer(@U[0].Arr^[0])^;
          src2 := pPointer(@U[0].Arr^[1])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseAND(src1, src2, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@dst);
          Result:=0;
       end;
   end;
 end;

 ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TBITWISEOR   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////
function    TBITWISEOR.GetParamID;
begin
  Result:=-1;
end;

function TBITWISEOR.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
var res,i: integer;
begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 0;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TBITWISEOR.RunFunc;
var res: Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          src1 := pPointer(@U[0].Arr^[0])^;
          src2 := pPointer(@U[0].Arr^[1])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseOR(src1, src2, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@dst);
          Result:=0;
       end;
   end;
 end;

 ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TBITWISENO   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TBITWISENO.GetParamID;
begin
  Result:=-1;
end;

function TBITWISENO.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;

begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 0;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TBITWISENO.RunFunc;
var res: Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          src := pPointer(@U[0].Arr^[0])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseNO(src, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@dst);
          Result:=0;
       end;
   end;
 end;

///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TBITWISEXOR   ///////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TBITWISEXOR.GetParamID;
begin
  Result:=-1;
end;

function TBITWISEXOR.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;

begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 0;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TBITWISEXOR.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          src1 := pPointer(@U[0].Arr^[0])^;
          src2 := pPointer(@U[0].Arr^[1])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseXOR(src1, src2, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@bitwiseXOR);
          Result:=0;
       end;
   end;
 end;

   //***********++++++++++++

///////////////////////////////////////////////////////////////////////////
//////////////////////////////    tAddWeighted   //////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TperElementAddWeighted.GetParamID;
begin
  Result:=-1;
end;

function TperElementAddWeighted.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;

begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 0;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TperElementAddWeighted.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          src1 := pPointer(@U[0].Arr^[0])^;
          alpha     :=  U[0].Arr^[1];
          src2 := pPointer(@U[0].Arr^[2])^;
          beta      :=  U[0].Arr^[3];
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := perElementAddWeighted(src1, alpha, src2, beta, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@dst);
          Result:=0;
       end;
   end;
 end;

///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TperElementDIV   ////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TperElementDIV.GetParamID;
begin
  Result:=-1;
end;

function TperElementDIV.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;

begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 0;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TperElementDIV.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          scale     := U[0].Arr[0];
          src1 := pPointer(@U[0].Arr^[1])^;
          src2 := pPointer(@U[0].Arr^[2])^;
          dst  := pPointer(@Y[0].Arr^[0])^;

          res := perElementDIV(scale, src1, src2, @dst);

          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@dst);
          Result:=0;
       end;
   end;
 end;



///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TperElementMUL   ////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TperElementMUL.GetParamID;
begin
  Result:=-1;
end;

function TperElementMUL.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;

begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      cY[0] := 0;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TperElementMUL.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          Result:=0;
       end;

    f_GoodStep:
       begin
          scale     := U[0].Arr[0];
          src1 := pPointer(@U[0].Arr^[1])^;
          src2 := pPointer(@U[0].Arr^[2])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := perElementMUL(scale, src1, src2, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@dst);
          Result:=0;
       end;
   end;
 end;


 //***********************************************

 ///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

var
  hDll: THandle;

initialization
  hDll := LoadLibrary('simintechVisLib.dll');

  // Открыть изображение из файла
  openImage := GetProcAddress(hDll, 'openImage');
  // Показать изображение
  showFrame := GetProcAddress(hDll, 'showFrame');

  // Открыть источник изображений
  openVideoSource := GetProcAddress(hDll, 'openVideoSource');
  // Получить изображение из источника
  retrieveImage := GetProcAddress(hDll, 'retrieveImage');

  //Очистка ресурсов
  releaseSourse := GetProcAddress(hDll, 'releaseSourse');
  releaseSimMat := GetProcAddress(hDll, 'releaseSimMat');

  convertColor := GetProcAddress(hDll, 'sim_convertColor');

  createHandledWindow := GetProcAddress(hDll, 'createHandledWindow');
  destroyWindowByName := GetProcAddress(hDll, 'destroyWindowByName');
  destroyAllWindows := GetProcAddress(hDll, 'destroyAllWindows');
  getWindowHandle := GetProcAddress(hDll, 'getWindowHandle');

  bitwiseAND := GetProcAddress(hDll,'bitwiseAND');
  bitwiseOR  := GetProcAddress(hDll,'bitwiseOR');
  bitwiseNO := GetProcAddress(hDll,'bitwiseNO');
  bitwiseXOR := GetProcAddress(hDll,'bitwiseXOR');

  perElementAddWeighted  := GetProcAddress(hDll,'perElementAddWeighted');
  perElementDIV          := GetProcAddress(hDll,'perElementDIV');
  perElementMUL          := GetProcAddress(hDll,'perElementMUL');


finalization
  if hDll <> 0 then FreeLibrary(hDll);
end.


