
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
 //**************************************************************************//
 //                 Определяем классы для каждой функции библиотеки          //
 //**************************************************************************//

TFRAMESOURCE = class(TRunObject)
        public
            sourceName:    String;
            source:        Pointer;
            frame:         Pointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
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
TIMSHOW = class(TRunObject)
        public
            windowName:    String;
            delay:         Integer;
            frame:         Pointer;

            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TCOLORCONVERT = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            code:    Integer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TBITWISEAND = class(TRunObject)
        public
            src1:    Pointer;
            src2:    Pointer;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TBITWISEOR = class(TRunObject)
        public
            src1:    Pointer;
            src2:    Pointer;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TBITWISENO = class(TRunObject)
        public
            src:    Pointer;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TBITWISEXOR = class(TRunObject)
        public
            src1:    Pointer;
            src2:    Pointer;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TperElementAddWeighted = class(TRunObject)
        public
            src1:    Pointer;
            alpha:    RealType;
            src2:    Pointer;
            beta:    RealType;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TperElementDIV = class(TRunObject)
        public
            scale:    RealType;
            src1:    Pointer;
            src2:    Pointer;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TperElementMUL = class(TRunObject)
        public
            scale:    RealType;
            src1:    Pointer;
            src2:    Pointer;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TperElementADDV = class(TRunObject)
        public
            src:    Pointer;
            val:    RealType;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TperElementMULV = class(TRunObject)
        public
            src:    Pointer;
            val:    RealType;
            dst:    pPointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TTRESHOLD = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            Thresh:    RealType;
            Maxval:    RealType;
            codetype:    Integer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TADAPTRESHOLD = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            maxValue:    RealType;
            adaptiveMethod:    Integer;
            ThresholdType:    Integer;
            blocksize:    Integer;
            C:    RealType;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TBILATERATEFILTER = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            d:    Integer;
            SigmaColor:    RealType;
            SigmaSpace:    RealType;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TBLUR = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            ksizeX:    Integer;
            ksizeY:    Integer;
            anchorX:    Integer;
            anchorY:    Integer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TBOXFILTER = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            ddepth:    Integer;
            ksizeX:    Integer;
            ksizeY:    Integer;
            anchorX:    Integer;
            anchorY:    Integer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TCANNY = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            Threshold1:    RealType;
            Threshold2:    RealType;
            apertureSize:    Integer;
            L2gradient:    boolean;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TCORNERHARRIS = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            blocksize:    Integer;
            ksize:    Integer;
            k:    RealType;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TDILATE = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            blocksize:    Integer;
            ksize:    Integer;
            kshape:    Integer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TERODE = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            blocksize:    Integer;
            ksize:    Integer;
            kShape:    Integer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TSPLIT = class(TRunObject)
        public
            src:    Pointer;
            dst1:    Pointer;
            dst2:    Pointer;
            dst3:    Pointer;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TINRANGE = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            lower:    RealType;
            upper:    RealType;

            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
TwarpPerspective = class(TRunObject)
        public
            src:    Pointer;
            dst:    Pointer;
            srcPts:    Array[1..8] of RealType;
            dstPts:    Array[1..8] of RealType;
            dsizeX:    Integer;
            dsizeY:    Integer;
            function       InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;override;
            function       RunFunc(var at,h : RealType;Action:Integer):NativeInt;override;
            function       GetParamID(const ParamName:string;var DataType:TDataType;var IsConst: boolean):NativeInt;override;
        end;
 //**************************************************************************//
 //                 Определяем ссылки для каждой функции библиотеки          //
 //**************************************************************************//
var

createHandledWindow : function( windowName : AnsiString): Pointer; cdecl;
getWindowHandle : function( windowName : AnsiString): Pointer; cdecl;
retrieveImage : function(sourse: Pointer; frame: pPointer):Integer; cdecl;
releaseSimMat : function( source : pPointer): Integer; cdecl;
releaseSourse : function( source : Pointer): Integer; cdecl;
destroyWindowByName : function(windowName: AnsiString):Integer; cdecl;
destroyAllWindows : function( err : AnsiString): Integer; cdecl;
openVideoSource : function(sourse: pPointer; windowName: AnsiString):Integer; cdecl;
openImage : function(frame: pPointer; windowName: AnsiString; code:Integer):Integer; cdecl;
showFrame : function(sourse: Pointer; delay: Integer; windowName: AnsiString):Integer; cdecl;
sim_convertColor : function( src : Pointer; dst : Pointer; code : Integer): Integer; cdecl;
bitwiseAND : function( src1 : Pointer; src2 : Pointer; dst : pPointer): Integer; cdecl;
bitwiseOR : function( src1 : Pointer; src2 : Pointer; dst : pPointer): Integer; cdecl;
bitwiseNO : function( src : Pointer; dst : pPointer): Integer; cdecl;
bitwiseXOR : function( src1 : Pointer; src2 : Pointer; dst : pPointer): Integer; cdecl;
perElementAddWeighted : function( src1 : Pointer; alpha : RealType; src2 : Pointer; beta : RealType; dst : pPointer): Integer; cdecl;
perElementDIV : function( scale : RealType; src1 : Pointer; src2 : Pointer; dst : pPointer): Integer; cdecl;
perElementMUL : function( scale : RealType; src1 : Pointer; src2 : Pointer; dst : pPointer): Integer; cdecl;
perElementADDV : function( src : Pointer; val : RealType; dst : pPointer): Integer; cdecl;
perElementMULV : function( src : Pointer; val : RealType; dst : pPointer): Integer; cdecl;
sim_threshold : function( src : Pointer; dst : Pointer; Thresh : Double; Maxval : RealType; codetype : Integer): Integer; cdecl;
sim_adaptiveThreshold : function( src : Pointer; dst : Pointer; maxValue : RealType; adaptiveMethod : Integer; ThresholdType : Integer; blocksize : Integer; C : RealType): Integer; cdecl;
sim_bilateralFilter : function( src : Pointer; dst : Pointer; d : Integer; SigmaColor : RealType; SigmaSpace : RealType): Integer; cdecl;
sim_blur : function( src : Pointer; dst : Pointer; ksizeX : Integer; ksizeY : Integer; anchorX : Integer; anchorY : Integer): Integer; cdecl;
sim_boxFilter : function( src : Pointer; dst : Pointer; ddepth : Integer; ksizeX : Integer; ksizeY : Integer; anchorX : Integer; anchorY : Integer): Integer; cdecl;
sim_canny : function( src : Pointer; dst : Pointer; Threshold1 : RealType; Threshold2 : RealType; apertureSize : Integer; L2gradient : boolean): Integer; cdecl;
sim_cornerHarris : function( src : Pointer; dst : Pointer; blocksize : Integer; ksize : Integer; k : RealType): Integer; cdecl;
sim_dilate : function( src : Pointer; dst : Pointer; blocksize : Integer; ksize : Integer; kshape : Integer): Integer; cdecl;
sim_erode : function( src : Pointer; dst : Pointer; blocksize : Integer; ksize : Integer; kShape : Integer): Integer; cdecl;
sim_split : function( src : Pointer; dst1 : Pointer; dst2 : Pointer; dst3 : Pointer): Integer; cdecl;
sim_inRange : function( src : Pointer; dst : Pointer; lower : Pointer; upper : Pointer): Integer; cdecl;
sim_warpPerspective : function( src : Pointer; dst : Pointer; srcPts : Pointer; dstPts : Pointer; dsizeX : Integer; dsizeY : Integer): Integer; cdecl;


implementation

uses math;

////////////////////////////////////////////////////////////////////////////
/////                                   TFRAMESOURCE                  //////
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
          Result:=0;
		end;
	f_GoodStep:
		begin
           if res = 0 then
           begin
               res := retrieveImage(source, @frame);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:= frame;
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

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                        TIMREAD                  //////
////////////////////////////////////////////////////////////////////////////


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
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

           frame := pPointer(@U[0].Arr^[0])^;
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

       begin
           if res = 0 then
           begin
              releaseSimMat(@frame);
           end;
       end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                        TIMSHOW                  //////
////////////////////////////////////////////////////////////////////////////


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
       end


    end
end;

function   TIMSHOW.RunFunc;
var res:Integer;
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

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                  TCOLORCONVERT                  //////
////////////////////////////////////////////////////////////////////////////


function    TCOLORCONVERT.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'code') then begin
            Result:=NativeInt(@code);
			DataType:=dtInteger;
       end


    end
end;

function TCOLORCONVERT.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TCOLORCONVERT.RunFunc;
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
          src := pPointer(@U[0].Arr^[0])^;
           Case code of
              integer(BGR_2_RGB):
                 res := sim_convertColor(src, @dst, 4);
              integer(RGBA_2_RGB):
                 res := sim_convertColor(src, @dst, 1);
              integer(RGB_2_BGR):
                 res := sim_convertColor(src, @dst, 4);
              integer(RGB_2_GRAY):
                 res := sim_convertColor(src, @dst, 7);
              integer(RGB_2_HSV):
                 res := sim_convertColor(src, @dst, 41);
           End;
           pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin
          releaseSimMat(@dst);
          Result:=0;
		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                    TBITWISEAND                  //////
////////////////////////////////////////////////////////////////////////////


function    TBITWISEAND.GetParamID;
begin
    Result:=-1;
end;

function TBITWISEAND.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TBITWISEAND.RunFunc;
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
          src2 := pPointer(@U[1].Arr^[0])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseAND(src1, src2, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                     TBITWISEOR                  //////
////////////////////////////////////////////////////////////////////////////


function    TBITWISEOR.GetParamID;
begin
    Result:=-1;
end;

function TBITWISEOR.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TBITWISEOR.RunFunc;
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
          src2 := pPointer(@U[1].Arr^[0])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseOR(src1, src2, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                     TBITWISENO                  //////
////////////////////////////////////////////////////////////////////////////


function    TBITWISENO.GetParamID;
begin
    Result:=-1;
end;

function TBITWISENO.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TBITWISENO.RunFunc;
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

          src := pPointer(@U[0].Arr^[0])^;
          dst := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseNO(src, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                    TBITWISEXOR                  //////
////////////////////////////////////////////////////////////////////////////


function    TBITWISEXOR.GetParamID;
begin
    Result:=-1;
end;

function TBITWISEXOR.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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
          src2 := pPointer(@U[1].Arr^[0])^;
          dst  := pPointer(@Y[0].Arr^[0])^;
          res := bitwiseXOR(src1, src2, @dst);
          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                           TperElementAddWeighted                  //////
////////////////////////////////////////////////////////////////////////////


function    TperElementAddWeighted.GetParamID;
begin
    Result:=-1;
end;

function TperElementAddWeighted.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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
          res := perElementAddWeighted(src1,alpha, src2, beta, @dst);
//  perElementAddWeighted : function(src1 : Pointer; alpha : ^RealType; src2: Pointer;  beta : ^RealType;  dst : pPointer):AnsiString;
          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                 TperElementDIV                  //////
////////////////////////////////////////////////////////////////////////////


function    TperElementDIV.GetParamID;
begin
    Result:=-1;
end;

function TperElementDIV.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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
          src1 := pPointer(@U[1].Arr^[0])^;
          src2 := pPointer(@U[2].Arr^[0])^;
          dst  := pPointer(@Y[0].Arr^[0])^;

          res := perElementDIV(scale, src1, src2, @dst);

          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                 TperElementMUL                  //////
////////////////////////////////////////////////////////////////////////////


function    TperElementMUL.GetParamID;
begin
    Result:=-1;
end;

function TperElementMUL.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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
          src1 := pPointer(@U[1].Arr^[0])^;
          src2 := pPointer(@U[2].Arr^[0])^;
          dst  := pPointer(@Y[0].Arr^[0])^;

          res := perElementDIV(scale, src1, src2, @dst);

          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                TperElementADDV                  //////
////////////////////////////////////////////////////////////////////////////


function    TperElementADDV.GetParamID;
begin
    Result:=-1;
end;

function TperElementADDV.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TperElementADDV.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin

          pPointer(@Y[0].Arr^[0])^ := nil;
          dst := nil;
          Result:=0;
		end;
	f_GoodStep:
		begin


          src := pPointer(@U[0].Arr^[0])^;

          dst  := pPointer(@Y[0].Arr^[0])^;

          if cU.Count = 2  then // попробуем проверить на наличие второго входа

              res := perElementADDV(src, U[1].Arr^[0], @dst)
          else
              res := perElementADDV(src, val, @dst);

          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                TperElementMULV                  //////
////////////////////////////////////////////////////////////////////////////


function    TperElementMULV.GetParamID;
begin
    Result:=-1;
end;

function TperElementMULV.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TperElementMULV.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin

          pPointer(@Y[0].Arr^[0])^ := nil;
          dst := nil;
          Result:=0;
		end;
	f_GoodStep:
		begin


          src := pPointer(@U[1].Arr^[0])^;

          dst  := pPointer(@Y[0].Arr^[0])^;

          if cU.Count = 2  then // попробуем проверить на наличие второго входа

              res := perElementMULV(src, U[1].Arr^[0], @dst)
          else
              res := perElementMULV(src, val, @dst);

          pPointer(@Y[0].Arr^[0])^:=dst;

		end;
	f_Stop:
		begin

          releaseSimMat(@dst);
          Result:=0;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                      TTRESHOLD                  //////
////////////////////////////////////////////////////////////////////////////


function    TTRESHOLD.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'Thresh') then begin
            Result:=NativeInt(@Thresh);
       DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'Maxval') then begin
            Result:=NativeInt(@Maxval);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'codetype') then
       begin
            Result:=NativeInt(@codetype);
			      DataType:=dtInteger;
       end


    end
end;

function TTRESHOLD.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TTRESHOLD.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin
           src := pPointer(@U[0].Arr^[0])^;
          // Thresh := U[1].Arr^[0];
          // Maxval := U[2].Arr^[0];
           res := sim_threshold(src, @dst, Thresh, Maxval, codetype);
           if res = 0 then
           begin
              pPointer(@Y[0].Arr^[0])^:=dst;
           end
           else
           begin
             pPointer(@Y[0].Arr^[0])^:=nil;
           end;
		end;
	f_Stop:
		begin
            {
       begin
           if res = 0 then
           begin
              releaseSimMat(@dst);
           end;
       end;      }

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                  TADAPTRESHOLD                  //////
////////////////////////////////////////////////////////////////////////////


function    TADAPTRESHOLD.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'maxValue') then begin
            Result:=NativeInt(@maxValue);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'adaptiveMethod') then begin
            Result:=NativeInt(@adaptiveMethod);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'ThresholdType') then begin
            Result:=NativeInt(@ThresholdType);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'blocksize') then begin
            Result:=NativeInt(@blocksize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'C') then begin
            Result:=NativeInt(@C);
			DataType:=dtDouble;
       end


    end
end;

function TADAPTRESHOLD.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TADAPTRESHOLD.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

           src := pPointer(@U[0].Arr^[0])^;
           maxValue := U[1].Arr^[0];
           //adaptiveMethod := U[2].Arr^[0];
           //ThresholdType := U[3].Arr^[0];
           //blocksize := U[4].Arr^[0];
           C := U[5].Arr^[0];

           dst  := pPointer(@Y[0].Arr^[0])^;

           res := sim_adaptiveThreshold(src, @dst, maxValue, adaptiveMethod, ThresholdType,blocksize,C);
           if res = 0 then
           begin
              pPointer(@Y[0].Arr^[0])^:=dst;
           end
           else
           begin
             pPointer(@Y[0].Arr^[0])^:=nil;
           end;

		end;
	f_Stop:
		begin

       begin
           if res = 0 then
           begin
              releaseSimMat(@dst);
           end;
       end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                              TBILATERATEFILTER                  //////
////////////////////////////////////////////////////////////////////////////


function    TBILATERATEFILTER.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'d') then begin
            Result:=NativeInt(@d);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'SigmaColor') then begin
            Result:=NativeInt(@SigmaColor);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'SigmaSpace') then begin
            Result:=NativeInt(@SigmaSpace);
			DataType:=dtDouble;
       end


    end
end;

function TBILATERATEFILTER.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TBILATERATEFILTER.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

           src := pPointer(@U[0].Arr^[0])^;
           //d := U[1].Arr^[0];
           SigmaColor := U[2].Arr^[0];
           SigmaSpace := U[3].Arr^[0];

           dst  := pPointer(@Y[0].Arr^[0])^;

           res := sim_bilateralFilter(src, @dst, d,SigmaColor,SigmaSpace);
           if res = 0 then
           begin
              pPointer(@Y[0].Arr^[0])^:=dst;
           end
           else
           begin
             pPointer(@Y[0].Arr^[0])^:=nil;
           end;

		end;
	f_Stop:
		begin

       begin
           if res = 0 then
           begin
              releaseSimMat(@dst);
           end;
       end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                          TBLUR                  //////
////////////////////////////////////////////////////////////////////////////


function    TBLUR.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'ksizeX') then begin
            Result:=NativeInt(@ksizeX);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'ksizeY') then begin
            Result:=NativeInt(@ksizeY);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'anchorX') then begin
            Result:=NativeInt(@anchorX);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'anchorY') then begin
            Result:=NativeInt(@anchorY);
			DataType:=dtInteger;
       end


    end
end;

function TBLUR.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TBLUR.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

           src := pPointer(@U[0].Arr^[0])^;
           //ksizeX := U[1].Arr^[0];
           //ksizeY := U[2].Arr^[0];
           //anchorX := U[3].Arr^[0];
           //anchorY := U[4].Arr^[0];   //

           dst  := pPointer(@Y[0].Arr^[0])^;

           res := sim_blur(src, @dst, ksizeX,ksizeY,anchorX,anchorY);
           if res = 0 then
           begin
              pPointer(@Y[0].Arr^[0])^:=dst;
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
              releaseSimMat(@dst);
           end;


		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                     TBOXFILTER                  //////
////////////////////////////////////////////////////////////////////////////


function    TBOXFILTER.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'ddepth') then begin
            Result:=NativeInt(@ddepth);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'ksizeX') then begin
            Result:=NativeInt(@ksizeX);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'ksizeY') then begin
            Result:=NativeInt(@ksizeY);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'anchorX') then begin
            Result:=NativeInt(@anchorX);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'anchorY') then begin
            Result:=NativeInt(@anchorY);
			DataType:=dtInteger;
       end


    end
end;

function TBOXFILTER.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TBOXFILTER.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

                src := pPointer(@U[0].Arr^[0])^;
                //ddepth := U[1].Arr^[0];
                //ksizeX := U[2].Arr^[0];
                //ksizeY := U[3].Arr^[0];
                //anchorX := U[4].Arr^[0];
                //anchorY := U[5].Arr^[0];

                dst  := pPointer(@Y[0].Arr^[0])^;


               res := sim_boxFilter(src, @dst, ddepth, ksizeX, ksizeY, anchorX, anchorY);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst;
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
                  releaseSimMat(@dst);
               end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                         TCANNY                  //////
////////////////////////////////////////////////////////////////////////////


function    TCANNY.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'Threshold1') then begin
            Result:=NativeInt(@Threshold1);
			DataType:=dtString;
       end

		else

       if StrEqu(ParamName,'Threshold2') then begin
            Result:=NativeInt(@Threshold2);
			DataType:=dtString;
       end

		else

       if StrEqu(ParamName,'apertureSize') then begin
            Result:=NativeInt(@apertureSize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'L2gradient') then begin
            Result:=NativeInt(@L2gradient);
			DataType:=dtBool;
       end


    end
end;

function TCANNY.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TCANNY.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

               src := pPointer(@U[0].Arr^[0])^;
               Threshold1 := U[1].Arr^[0];
               Threshold2 := U[2].Arr^[0];
              //apertureSize := integer(U[3].Arr^[0]);
               //L2gradient := U[4].Arr^[0];


               dst  := pPointer(@Y[0].Arr^[0])^;

               res := sim_canny(src, @dst, Threshold1, Threshold2,apertureSize,L2gradient);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst;
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
                  releaseSimMat(@dst);
               end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                  TCORNERHARRIS                  //////
////////////////////////////////////////////////////////////////////////////


function    TCORNERHARRIS.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'blocksize') then begin
            Result:=NativeInt(@blocksize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'ksize') then begin
            Result:=NativeInt(@ksize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'k') then begin
            Result:=NativeInt(@k);
			DataType:=dtDouble;
       end


    end
end;

function TCORNERHARRIS.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TCORNERHARRIS.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

               src := pPointer(@U[0].Arr^[0])^;
               //blocksize := U[1].Arr^[0];
               //ksize := U[2].Arr^[0];
               k := U[1].Arr^[0];



               dst  := pPointer(@Y[0].Arr^[0])^;

               res := sim_cornerHarris(src, @dst, blocksize, ksize,k);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst;
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
                  releaseSimMat(@dst);
               end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                        TDILATE                  //////
////////////////////////////////////////////////////////////////////////////


function    TDILATE.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'blocksize') then begin
            Result:=NativeInt(@blocksize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'ksize') then begin
            Result:=NativeInt(@ksize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'kshape') then begin
            Result:=NativeInt(@kshape);
			DataType:=dtInteger;
       end


    end
end;

function TDILATE.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TDILATE.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

               src := pPointer(@U[0].Arr^[0])^;
               //blocksize := U[1].Arr^[0];
               //ksize := U[2].Arr^[0];
               //kShape := U[3].Arr^[0];



               dst  := pPointer(@Y[0].Arr^[0])^;

               res := sim_dilate(src, @dst, blocksize, ksize,kShape);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst;
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
                  releaseSimMat(@dst);
               end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                         TERODE                  //////
////////////////////////////////////////////////////////////////////////////


function    TERODE.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'blocksize') then begin
            Result:=NativeInt(@blocksize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'ksize') then begin
            Result:=NativeInt(@ksize);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'kShape') then begin
            Result:=NativeInt(@kShape);
			DataType:=dtInteger;
       end


    end
end;

function TERODE.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TERODE.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

               src := pPointer(@U[0].Arr^[0])^;
               //blocksize := U[1].Arr^[0];
               //ksize := U[2].Arr^[0];
               //kShape := U[3].Arr^[0];



               dst  := pPointer(@Y[0].Arr^[0])^;

               res := sim_erode(src, @dst, blocksize, ksize,kShape);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst;
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
                  releaseSimMat(@dst);
               end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                         TSPLIT                  //////
////////////////////////////////////////////////////////////////////////////


function    TSPLIT.GetParamID;
begin
    Result:=-1;
end;

function TSPLIT.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TSPLIT.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

               src := pPointer(@U[0].Arr^[0])^;

               //dst1  := pPointer(@Y[0].Arr^[0])^;
               //dst2  := pPointer(@Y[1].Arr^[0])^;
               //dst3  := pPointer(@Y[2].Arr^[0])^;

               res := sim_split(src, @dst1, @dst2, @dst3);

               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst1;
                  pPointer(@Y[1].Arr^[0])^:=dst2;
                  pPointer(@Y[2].Arr^[0])^:=dst3;
               end
               else
               begin
                 pPointer(@Y[0].Arr^[0])^:=nil;
                 pPointer(@Y[1].Arr^[0])^:=nil;
                 pPointer(@Y[2].Arr^[0])^:=nil;
               end;

		end;
	f_Stop:
		begin

               if res = 0 then
               begin
                  releaseSimMat(@dst1);
                  releaseSimMat(@dst2);
                  releaseSimMat(@dst3);
               end;

		end;

    end
end;

////////////////////////////////////////////////////////////////////////////
/////                                       TINRANGE                  //////
////////////////////////////////////////////////////////////////////////////


function    TINRANGE.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'lower') then begin
            Result:=NativeInt(@lower);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'upper') then begin
            Result:=NativeInt(@upper);
			DataType:=dtDouble;
       end


    end
end;

function TINRANGE.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TINRANGE.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin

               src := pPointer(@U[0].Arr^[0])^;
               lower  := U[1].Arr^[0];
               upper  := U[2].Arr^[0];

               res := sim_inRange(src, @dst, @lower, @upper);

               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst;

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
                  releaseSimMat(@dst);

               end;

		end;

    end
end;
////////////////////////////////////////////////////////////////////////////
/////                               TwarpPerspective                  //////
////////////////////////////////////////////////////////////////////////////


function    TwarpPerspective.GetParamID;
begin
    Result:=inherited GetParamId(ParamName,DataType,IsConst);
    if Result = -1 then begin

       if StrEqu(ParamName,'dsizeX') then begin
            Result:=NativeInt(@dsizeX);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'dsizeY') then begin
            Result:=NativeInt(@dsizeY);
			DataType:=dtInteger;
       end

		else

       if StrEqu(ParamName,'srcX1') then begin
            Result:=NativeInt(@srcPts[1]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'srcY1') then begin
            Result:=NativeInt(@srcPts[2]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'srcX2') then begin
            Result:=NativeInt(@srcPts[3]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'srcY2') then begin
            Result:=NativeInt(@srcPts[4]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'srcX3') then begin
            Result:=NativeInt(@srcPts[5]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'srcY3') then begin
            Result:=NativeInt(@srcPts[6]);
			DataType:=dtDouble;
       end

    else

       if StrEqu(ParamName,'srcX4') then begin
            Result:=NativeInt(@srcPts[7]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'srcY4') then begin
            Result:=NativeInt(@srcPts[8]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'dstX1') then begin
            Result:=NativeInt(@dstPts[1]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'dstY1') then begin
            Result:=NativeInt(@dstPts[2]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'dstX2') then begin
            Result:=NativeInt(@dstPts[3]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'dstY2') then begin
            Result:=NativeInt(@dstPts[4]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'dstX3') then begin
            Result:=NativeInt(@dstPts[5]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'dstY3') then begin
            Result:=NativeInt(@dstPts[6]);
			DataType:=dtDouble;
       end
    else

       if StrEqu(ParamName,'dstX4') then begin
            Result:=NativeInt(@dstPts[7]);
			DataType:=dtDouble;
       end

		else

       if StrEqu(ParamName,'dstY4') then begin
            Result:=NativeInt(@dstPts[8]);
			DataType:=dtDouble;
       end

    end
end;

function TwarpPerspective.InfoFunc(Action: integer;aParameter: NativeInt):NativeInt;
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

function   TwarpPerspective.RunFunc;
var res:Integer;
begin
 Result:=0;
 case Action of
 	f_InitState:
		begin
		Result:=0;
		end;
	f_GoodStep:
		begin
               src := pPointer(@U[0].Arr^[0])^;
               dst  := pPointer(@Y[0].Arr^[0])^;

               res := sim_warpPerspective(src, @dst, @srcPts[1],@dstPts[1],dsizeX,dsizeY);
               if res = 0 then
               begin
                  pPointer(@Y[0].Arr^[0])^:=dst;
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
                  releaseSimMat(@dst);
               end;

		end;

    end
end;

//***********************************************************************//
//                    Раздел инициализации                               //
//***********************************************************************//

var
  hDll: THandle;

initialization
  hDll := LoadLibrary('simintechVisLib.dll');

createHandledWindow :=  GetProcAddress(hDll, 'createHandledWindow');
getWindowHandle :=  GetProcAddress(hDll, 'getWindowHandle');
//Получить изображение из источника
retrieveImage :=  GetProcAddress(hDll, 'retrieveImage');
//Очистка ресурсов
releaseSimMat :=  GetProcAddress(hDll, 'releaseSimMat');
releaseSourse :=  GetProcAddress(hDll, 'releaseSourse');
destroyWindowByName :=  GetProcAddress(hDll, 'destroyWindowByName');
destroyAllWindows :=  GetProcAddress(hDll, 'destroyAllWindows');
//Открыть источник изображений
openVideoSource :=  GetProcAddress(hDll, 'openVideoSource');
//Открыть изображение из файла
openImage :=  GetProcAddress(hDll, 'openImage');
//Показать изображение
showFrame :=  GetProcAddress(hDll, 'showFrame');
sim_convertColor :=  GetProcAddress(hDll, 'sim_convertColor');
bitwiseAND :=  GetProcAddress(hDll, 'bitwiseAND');
bitwiseOR :=  GetProcAddress(hDll, 'bitwiseOR');
bitwiseNO :=  GetProcAddress(hDll, 'bitwiseNO');
bitwiseXOR :=  GetProcAddress(hDll, 'bitwiseXOR');
perElementAddWeighted :=  GetProcAddress(hDll, 'perElementAddWeighted');
perElementDIV :=  GetProcAddress(hDll, 'perElementDIV');
perElementMUL :=  GetProcAddress(hDll, 'perElementMUL');
perElementADDV :=  GetProcAddress(hDll, 'perElementADDV');
perElementMULV :=  GetProcAddress(hDll, 'perElementMULV');
sim_threshold :=  GetProcAddress(hDll, 'sim_threshold');
sim_adaptiveThreshold :=  GetProcAddress(hDll, 'sim_adaptiveThreshold');
sim_bilateralFilter :=  GetProcAddress(hDll, 'sim_bilateralFilter');
sim_blur :=  GetProcAddress(hDll, 'sim_blur');
sim_boxFilter :=  GetProcAddress(hDll, 'sim_boxFilter');
sim_canny :=  GetProcAddress(hDll, 'sim_canny');
sim_cornerHarris :=  GetProcAddress(hDll, 'sim_cornerHarris');
sim_dilate :=  GetProcAddress(hDll, 'sim_dilate');
sim_erode :=  GetProcAddress(hDll, 'sim_erode');
sim_split :=  GetProcAddress(hDll, 'sim_split');
sim_inRange :=  GetProcAddress(hDll, 'sim_inRange');
sim_warpPerspective  :=  GetProcAddress(hDll, 'sim_warpPerspective ');

finalization
  if hDll <> 0 then FreeLibrary(hDll);
end.
