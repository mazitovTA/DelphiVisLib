//ErrorEvent('1!!!', msError, VisualObject);
unit Blocks;

interface

uses Windows, Classes, DataTypes, SysUtils, RunObjts, uExtMath;

type
  pPointer = ^Pointer;
  TConversionType = (BGR_2_RGB,
                     RGBA_2_RGB,
                     RGB_2_BGR,
                     RGB_2_GRAY,
                     RGB_2_HSV);

  TIMSHOW = class(TRunObject)
  public
    windowName:    String;
    delay:         Integer;
    _frame:        Pointer;

    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TIMREAD = class(TRunObject)
  public
    source:        String;
    sourceType:    TIntArray;
    _source:       Pointer;
    _frame:        Pointer;

    res:           Integer;
    notReady:      Integer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TFRAMESOURCE = class(TRunObject)
  public
    source:        String;
    sourceType:    TIntArray;
    _source:       Pointer;
    _frame:        Pointer;

    res:           Integer;
    notReady:      Integer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TCOLORCONVERT = class(TRunObject)
  public
    _srcFrame:     Pointer;
    _dstFrame:     Array of Pointer;
    code:          Integer;
    outNum:        Integer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;

  TFRAMECOPY = class(TRunObject)
  public
    _srcFrame:     Pointer;
    _dstFrame:     Array of Pointer;
    outNum:        Integer;

    function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
    function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
    function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
  end;
  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////


var

  openImage : function( sourse: pPointer; windowName: AnsiString):Integer; cdecl;
  showFrame : function( frame: Pointer; delay: Integer; windowName: AnsiString):Integer; cdecl;

  openVideoSource : function( sourse: pPointer; windowName: AnsiString; frame: pPointer):Integer; cdecl;
  retrieveImage : function( sourse, frame: Pointer):Integer; cdecl;

  releaseSourse : function( sourse: Pointer):Integer; cdecl;
  releaseFrame : function( sourse: Pointer):Integer; cdecl;

  copyFrame : function( src: Pointer; dst: pPointer):Integer; cdecl;
  convertColor : function( src: Pointer; dst: pPointer; code: Integer):Integer; cdecl;

  createHandledWindow : function( windowName: AnsiString):Pointer; cdecl;
  destroyWindowByName : function( windowName: AnsiString):Integer; cdecl;
  destroyAllWindows : function():Integer; cdecl;
  getWindowHandle : function():Pointer; cdecl;


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
      Result:=NativeInt(@source);
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
begin
 Result:=0;
 case Action of
    f_InitState:
       begin
          notReady := openVideoSource(@_source, source, @_frame);
          Result:=0;
       end;

    f_GoodStep:
       begin
           if notReady = 0 then
           begin
               res := retrieveImage(_source, _frame);
               if res = 0 then
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
              res := -1;
              pPointer(@Y[0].Arr^[0])^:=nil;
           end;
       end;

    f_Stop:
       begin
           if res = 0 then
           begin
              releaseFrame(_frame);
           end;
           if notReady = 0 then
           begin
              releaseSourse(_source);
           end;
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
      Result:=NativeInt(@source);
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
begin
 Result:=0;
 case Action of
    f_InitState:
       begin
          Result:=0;
       end;

    f_GoodStep:
       begin
           res := openImage(@_source, source);
           if res = 0 then
           begin
              pPointer(@Y[0].Arr^[0])^:=_source;
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
              releaseFrame(_frame);
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
var res,i: integer;
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
           _frame := pPointer(@U[0].Arr^[0])^;
           res := showFrame(_frame, delay, windowName);
       end;

    f_Stop:
       begin
          destroyWindowByName(windowName);
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
    end
    else
    if StrEqu(ParamName,'outNum') then begin
      Result:=NativeInt(@outNum);
      DataType:=dtInteger;
    end;
  end
end;

function TCOLORCONVERT.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
var res,i: integer;
begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      if (outNum > 0) then begin
                         For i := 1 to outNum do
                         begin
                          cY[i-1] := 1;
                         end;
                      end;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TCOLORCONVERT.RunFunc;
var res,i: integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          if (outNum > 0) then begin
             For i := 1 to outNum do
               begin
                 pPointer(@Y[i-1].Arr^[0])^ := 0;
               end;
             if (outNum > 0) then begin
               SetLength(_dstFrame, outNum);
             end;
          end;
          Result:=0;
       end;

    f_GoodStep:
       begin
          _srcFrame := pPointer(@U[0].Arr^[0])^;
          if (outNum > 0) then begin
                 Case code of
                    integer(BGR_2_RGB):
                       convertColor(_srcFrame, @_dstFrame[0], 4);
                    integer(RGBA_2_RGB):
                       convertColor(_srcFrame, @_dstFrame[0], 1);
                    integer(RGB_2_BGR):
                       convertColor(_srcFrame, @_dstFrame[0], 4);
                    integer(RGB_2_GRAY):
                       convertColor(_srcFrame, @_dstFrame[0], 7);
                    integer(RGB_2_HSV):
                       convertColor(_srcFrame, @_dstFrame[0], 41);
                 End;
                 pPointer(@Y[0].Arr^[0])^:=_dstFrame[0];
          end;

          if (outNum > 1) then begin
              For i := 1 to (outNum - 1) do
               begin
                 copyFrame(_dstFrame[0], @_dstFrame[i]);
                 pPointer(@Y[i].Arr^[0])^:=_dstFrame[i];
               end;
          end;
       end;

   end;
 end;
  ///////////////////////////////////////////////////////////////////////////
//////////////////////////////    TFRAMECOPY   ///////////////////////////////
///////////////////////////////////////////////////////////////////////////

function    TFRAMECOPY.GetParamID;
begin
  Result:=inherited GetParamId(ParamName,DataType,IsConst);
  if Result = -1 then begin
    if StrEqu(ParamName,'outNum') then begin
      Result:=NativeInt(@outNum);
      DataType:=dtInteger;
    end
  end
end;

function TFRAMECOPY.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
var res,i: integer;
begin
  Result:=0;
  case Action of
    i_GetCount:    begin
                      if (outNum > 0) then begin
                         For i := 1 to outNum do
                         begin
                          cY[i-1] := 1;
                         end;
                      end;
                   end;
  else
    Result:=inherited InfoFunc(Action,aParameter);
  end
end;

function   TFRAMECOPY.RunFunc;
var res,i: integer;
begin
 Result:=0;
 case Action of
   f_InitState:
       begin
          if (outNum > 0) then begin
             For i := 1 to outNum do
               begin
                 pPointer(@Y[i-1].Arr^[0])^ := 0;
               end;
             if (outNum > 1) then begin
               SetLength(_dstFrame, outNum - 1);
             end;
          end;
          Result:=0;
       end;

    f_GoodStep:
       begin
          _srcFrame := pPointer(@U[0].Arr^[0])^;
          if (outNum = 1) then begin
              pPointer(@Y[0].Arr^[0])^:=_srcFrame;
          end;
          if (outNum > 1) then begin
              pPointer(@Y[0].Arr^[0])^:=_srcFrame;
              For i := 2 to outNum do
               begin
                 res := copyFrame(_srcFrame, @_dstFrame[i-2]);
                 pPointer(@Y[i-1].Arr^[0])^:=_dstFrame[i-2];
               end;
          end;
       end;
   end;
 end;

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
  releaseFrame := GetProcAddress(hDll, 'releaseFrame');

  copyFrame := GetProcAddress(hDll, 'copyFrame');
  convertColor := GetProcAddress(hDll, 'convertColor');

  createHandledWindow := GetProcAddress(hDll, 'createHandledWindow');
  destroyWindowByName := GetProcAddress(hDll, 'destroyWindowByName');
  destroyAllWindows := GetProcAddress(hDll, 'destroyAllWindows');
  getWindowHandle := GetProcAddress(hDll, 'getWindowHandle');

finalization
  if hDll <> 0 then FreeLibrary(hDll);
end.


