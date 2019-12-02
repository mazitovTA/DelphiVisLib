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
    windowName:    AnsiString;
    err:           AnsiString;
    delay:         Integer;
    _frame:        Pointer;

    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TIMREAD = class(TRunObject)
  public
    frame:         Pointer;
    sourceName:    AnsiString;
    code:          Integer;
    err:           AnsiString;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TFRAMESOURCE = class(TRunObject)
  public
    source:        Pointer;
    sourceName:    AnsiString;
    err:           AnsiString;
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
    err:           AnsiString;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISEAND = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    dst:           Pointer;
    err:           AnsiString;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISEOR = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    dst:           Pointer;
    err:           AnsiString;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISENO = class(TRunObject)
  public
    src:          Pointer;
    dst:           Pointer;
    err:           AnsiString;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TBITWISEXOR = class(TRunObject)
  public
    src1:          Pointer;
    src2:          Pointer;
    dst:           Pointer;
    err:           AnsiString;

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
    err:           AnsiString;

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
    err:           AnsiString;

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
    err:           AnsiString;

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

  openImage : function(frame: pPointer; windowName: AnsiString; code:Integer; err:AnsiString):Integer; cdecl;
  showFrame : function(sourse: Pointer; delay: Integer; windowName,err: AnsiString):Integer; cdecl;
  openVideoSource : function(sourse: pPointer; windowName,err: AnsiString):Integer; cdecl;
  retrieveImage : function(sourse: Pointer; frame: pPointer; err:AnsiString):Integer; cdecl;
  releaseSourse : function(sourse: Pointer; err:AnsiString):Integer; cdecl;
  destroyWindowByName : function(windowName: AnsiString; err:AnsiString):Integer; cdecl;
  destroyAllWindows : function(err:AnsiString):Integer; cdecl;

  bitwiseAND : function(src1, src2 : Pointer; dst: pPointer; err:AnsiString):Integer; cdecl;
  bitwiseOR  : function(src1, src2 : Pointer; dst: pPointer; err:AnsiString):Integer; cdecl;
  bitwiseNO  : function(src1 : Pointer; dst: pPointer; err:AnsiString):Integer; cdecl;
  bitwiseXOR : function(src1, src2 : Pointer; dst: pPointer; err:AnsiString):Integer; cdecl;

  perElementAddWeighted : function(src1 : Pointer; alpha : Double; src2: Pointer;  beta : Double;  dst : pPointer; err:AnsiString):Integer; cdecl;
  perElementDIV : function(scale : Double; src1 : Pointer; src2 : Pointer;  dst : pPointer; err:AnsiString):Integer; cdecl;
  perElementMUL : function(scale : Double; src1 : Pointer; src2 : Pointer;  dst : pPointer; err:AnsiString):Integer; cdecl;




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
var res:AnsiString;
begin
 Result:=0;
 case Action of
    f_InitState:
       begin
          //res := openVideoSource(@_source, sourceName);
          ErrorEvent(sourceName, msError, VisualObject);
          //notReady := 1;//************************** обработать res
          Result:=0;
       end;

    f_GoodStep:
       begin
          ErrorEvent(sourceName, msError, VisualObject);
       {
           if notReady = 0 then
           begin
               res := retrieveImage(_source, @_frame);
               ErrorEvent('res', msError, VisualObject);
               if res = '0' then
               begin
                  pPointer(@Y[0].Arr^[0])^:=_frame;
               end
               else
               begin
                  pPointer(@Y[0].Arr^[0])^:=nil;
               end;
           end
           else
           begin
              res := '-1';
              pPointer(@Y[0].Arr^[0])^:=nil;
           end;
           }
       end;

    f_Stop:
       begin

       {
           if res = '0' then
           begin
              releaseSimMat(@_frame);
           end;
           if notReady = 0 then
           begin
              releaseSourse(_source);
           end;
           }
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
           res := openImage(@frame, sourceName, code, err);
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
           if res = 0 then
           begin
              releaseSimMat(@frame);
           end;
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
var res: AnsiString;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          ErrorEvent(windowName, msError, VisualObject);
          //createHandledWindow(windowName);
          Result:=0;
       end;

    f_GoodStep:
       begin
          // _frame := pPointer(@U[0].Arr^[0])^;
           //res := showFrame(_frame, delay, windowName);
       end;

    f_Stop:
       begin
          //destroyWindowByName(windowName);
          Result:=0;
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
var res :AnsiString;
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
          _srcFrame := pPointer(@U[0].Arr^[0])^;
           Case code of
           {
              integer(BGR_2_RGB):
                 res := convertColor(_srcFrame, @_dstFrame, 4);
              integer(RGBA_2_RGB):
                 res := convertColor(_srcFrame, @_dstFrame, 1);
              integer(RGB_2_BGR):
                 res := convertColor(_srcFrame, @_dstFrame, 4);
              integer(RGB_2_GRAY):
                 res := convertColor(_srcFrame, @_dstFrame, 7);
              integer(RGB_2_HSV):
                 res := convertColor(_srcFrame, @_dstFrame, 41);
                 }
           End;
          pPointer(@Y[0].Arr^[0])^:=_dstFrame;
       end;
   end;
 end;


 //**************************************************

 ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TBITWISEAND   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TBITWISEAND.GetParamID;
begin
  {Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
  }
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
var res: AnsiString;
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
          _src1Frame := pPointer(@U[0].Arr^[0])^;
          _src2Frame := pPointer(@U[0].Arr^[1])^;
          _dstFrame  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseAND(_src1Frame, _src2Frame, @_dstFrame);
          pPointer(@Y[0].Arr^[0])^:=_dstFrame;
       end;

    f_Stop:
       begin
          releaseSimMat(@_dstFrame);
          Result:=0;
       end;
   end;
 end;

 ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TBITWISEOR   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////
function    TBITWISEOR.GetParamID;
begin
  {Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
  }
  Result:=-1;
end;

function TBITWISEOR.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
//var res,i: integer;
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
          res := bitwiseOR(src1, src2, @dst, err);
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
  {Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
  }
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
          res := bitwiseNO(src, @dst, err);
          pPointer(@Y[0].Arr^[0])^:=dst;
       end;

    f_Stop:
       begin
          releaseSimMat(@_dstFrame);
          Result:=0;
       end;
   end;
 end;

 ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TBITWISEXOR   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TBITWISEXOR.GetParamID;
begin
  {Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
  }
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
          res := bitwiseXOR(src1, src2, @dst, err);
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
//////////////////////////////    tAddWeighted   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TperElementAddWeighted.GetParamID;
begin
  {Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
  }
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
          res := perElementAddWeighted(src1,alpha, src2, beta, @_dst;
//  perElementAddWeighted : function(src1 : Pointer; alpha : ^RealType; src2: Pointer;  beta : ^RealType;  dst : pPointer):AnsiString;
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
//////////////////////////////    TperElementDIV   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TperElementDIV.GetParamID;
begin
  {Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
  }
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
var res:AnsiString;
    _scale : RealType;
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
          _scale     := U[0].Arr[0];
          _src1Frame := pPointer(@U[0].Arr^[1])^;
          _src2Frame := pPointer(@U[0].Arr^[2])^;
          _dstFrame  := pPointer(@Y[0].Arr^[0])^;

          res := perElementDIV(_scale, _src1Frame, _src2Frame, @_dstFrame);

          pPointer(@Y[0].Arr^[0])^:=_dstFrame;
       end;

    f_Stop:
       begin
          releaseSimMat(@_dstFrame);
          Result:=0;
       end;
   end;
 end;



///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TperElementMUL   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TperElementMUL.GetParamID;
begin
  {Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'code') then begin
      Result:=NativeInt(@code);
      DataType:=dtInteger;
    end;
  end
  }
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
var res:AnsiString;
    _scale : RealType;
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
          _scale     := U[0].Arr[0];
          _src1Frame := pPointer(@U[0].Arr^[1])^;
          _src2Frame := pPointer(@U[0].Arr^[2])^;
          _dstFrame  := pPointer(@Y[0].Arr^[0])^;
          res := perElementMUL(_scale,_src1Frame, _src2Frame, @_dstFrame);

          pPointer(@Y[0].Arr^[0])^:=_dstFrame;
       end;

    f_Stop:
       begin
          releaseSimMat(@_dstFrame);
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

  copyFrame := GetProcAddress(hDll, 'copyFrame');
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


