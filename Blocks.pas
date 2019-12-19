// ErrorEvent('1!!!', msError, VisualObject);
unit Blocks;

interface

uses Windows, Classes, DataTypes, SysUtils, RunObjts, uExtMath, IntArrays;

type
  pPointer = ^Pointer;
  TConversionType = (BGR_2_RGB, RGBA_2_RGB, RGB_2_BGR, RGB_2_GRAY, RGB_2_HSV);
  TStructureElement = (MORPH_RECT, MORPH_CROSS, MORPH_ELLIPSE);
  TInterpolation = (INTER_NEAREST, INTER_LINEAR, INTER_CUBIC, INTER_AREA);

  // **************************************************************************//
  // Определяем классы для каждой функции библиотеки          //
  // **************************************************************************//

  TFRAMESOURCE = class(TRunObject)
  public
    sourceName: String;
    source: Pointer;
    frame: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TIMREAD = class(TRunObject)
  public
    frame: Pointer;
    sourceName: String;
    code: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TIMSHOW = class(TRunObject)
  public
    windowName: String;
    delay: integer;
    frame: Pointer;

    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TCONVERTCOLOR = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    code: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TBITWISEAND = class(TRunObject)
  public
    src1: Pointer;
    src2: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TBITWISEOR = class(TRunObject)
  public
    src1: Pointer;
    src2: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TBITWISENO = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TBITWISEXOR = class(TRunObject)
  public
    src1: Pointer;
    src2: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TmatrixMUL = class(TRunObject)
  public
    src1: Pointer;
    src2: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TperElementAddWeighted = class(TRunObject)
  public
    src1: Pointer;
    alpha: RealType;
    src2: Pointer;
    beta: RealType;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TABSDIFF = class(TRunObject)
  public
    src1: Pointer;
    src2: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TperElementMUL = class(TRunObject)
  public
    scale: RealType;
    src1: Pointer;
    src2: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TperElementADD = class(TRunObject)
  public
    src1: Pointer;
    src2: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TperElementADDV = class(TRunObject)
  public
    src: Pointer;
    Value: RealType;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TperElementMULV = class(TRunObject)
  public
    src: Pointer;
    Value: RealType;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TTRESHOLD = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    Thresh: Double;
    Maxval: Double;
    codetype: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TADAPTIVETHRESHOLD = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    maxValue: RealType;
    adaptiveMethod: integer;
    ThresholdType: integer;
    blocksize: integer;
    C: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TBILATERALFILTER = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    d: integer;
    SigmaColor: RealType;
    SigmaSpace: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TBLUR = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    ksizeX: integer;
    ksizeY: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TGAUSSIANBLUR = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    ksizeX: integer;
    ksizeY: integer;
    sigmaX: RealType;
    sigmaY: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TBOXFILTER = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    ksizeX: integer;
    ksizeY: integer;
    anchorX: integer;
    anchorY: integer;
    normalize: boolean;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TCANNY = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    Threshold1: RealType;
    Threshold2: RealType;
    apertureSize: integer;
    L2gradient: boolean;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TCORNERHARRIS = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    blocksize: integer;
    ksize: integer;
    k: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TDILATE = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    blocksize: integer;
    ksize: integer;
    kshape: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TERODE = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    blocksize: integer;
    ksize: integer;
    kshape: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TROI = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    roix: integer;
    roiy: integer;
    roiw: integer;
    roih: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TSPLIT = class(TRunObject)
  public
    src: Pointer;
    dst1: Pointer;
    dst2: Pointer;
    dst3: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TINRANGE = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    lower: RealType;
    upper: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TMERGE = class(TRunObject)
  public
    src1: Pointer;
    src2: Pointer;
    src3: Pointer;
    dst: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TSOBEL = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    dx: integer;
    dy: integer;
    ksize: integer;
    scale: RealType;
    delta: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TSCHARR = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    dx: integer;
    dy: integer;
    scale: RealType;
    delta: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TLAPLACIAN = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    ksize: integer;
    scale: RealType;
    delta: RealType;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TRESIZE = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    ksizeX: integer;
    ksizeY: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TRESIZEP = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    ksizeX: integer;
    ksizeY: integer;
    fx: RealType;
    fy: RealType;
    interpolation: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TwarpPerspective = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    srcPts: Array [1 .. 8] of RealType;
    dstPts: Array [1 .. 8] of RealType;
    dsizeX: integer;
    dsizeY: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TFloodFill = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    px: integer;
    py: integer;
    ch1: integer;
    ch2: integer;
    ch3: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  // **************************************************************************//
  // Определяем ссылки для каждой функции библиотеки          //
  // **************************************************************************//
var

  createHandledWindow: function(windowName: AnsiString): Pointer; cdecl;
  getWindowHandle: function(windowName: AnsiString): Pointer; cdecl;
  retrieveImage: function(source: Pointer; frame: pPointer): integer; cdecl;
  releaseSimMat: function(source: pPointer): integer; cdecl;
  releaseSourse: function(source: Pointer): integer; cdecl;
  destroyWindowByName: function(windowName: AnsiString): integer; cdecl;
  destroyAllWindows: function(err: AnsiString): integer; cdecl;
  openVideoSource: function(source: pPointer; windowName: AnsiString)
    : integer; cdecl;
  openImage: function(frame: pPointer; windowName: AnsiString; code: integer)
    : integer; cdecl;
  showFrame: function(source: Pointer; delay: integer; windowName: AnsiString)
    : integer; cdecl;
  sim_convertColor: function(src: Pointer; dst: pPointer; code: integer)
    : integer; cdecl;
  bitwiseAND: function(src1: Pointer; src2: Pointer; dst: pPointer)
    : integer; cdecl;
  bitwiseOR: function(src1: Pointer; src2: Pointer; dst: pPointer)
    : integer; cdecl;
  bitwiseNO: function(src: Pointer; dst: pPointer): integer; cdecl;
  bitwiseXOR: function(src1: Pointer; src2: Pointer; dst: pPointer)
    : integer; cdecl;
  matrixMUL: function(src1: Pointer; src2: Pointer; dst: pPointer)
    : integer; cdecl;
  perElementAddWeighted: function(src1: Pointer; alpha: RealType; src2: Pointer;
    beta: RealType; dst: pPointer): integer; cdecl;
  perElementMUL: function(scale: RealType; src1: Pointer; src2: Pointer;
    dst: pPointer): integer; cdecl;
  absDiff: function(src1: Pointer; src2: Pointer; dst: pPointer)
    : integer; cdecl;
  perElementADD: function(src1: Pointer; src2: Pointer; dst: pPointer)
    : integer; cdecl;
  perElementADDV: function(src: Pointer; val: RealType; dst: pPointer)
    : integer; cdecl;
  perElementMULV: function(src: Pointer; val: RealType; dst: pPointer)
    : integer; cdecl;
  sim_threshold: function(src: Pointer; dst: pPointer; Thresh: Double;
    Maxval: Double; codetype: integer): integer; cdecl;
  sim_adaptiveThreshold: function(src: Pointer; dst: pPointer;
    maxValue: RealType; adaptiveMethod: integer; ThresholdType: integer;
    blocksize: integer; C: RealType): integer; cdecl;
  sim_bilateralFilter: function(src: Pointer; dst: Pointer; d: integer;
    SigmaColor: RealType; SigmaSpace: RealType): integer; cdecl;
  sim_blur: function(src: Pointer; dst: pPointer; ksizeX: integer;
    ksizeY: integer): integer; cdecl;
  sim_gaussianBlur: function(src: Pointer; dst: pPointer; ksizeX: integer;
    ksizeY: integer; sigmaX: RealType; sigmaY: RealType): integer; cdecl;
  sim_boxFilter: function(src: Pointer; dst: pPointer; ksizeX: integer;
    ksizeY: integer; anchorX: integer; anchorY: integer; normalize: boolean)
    : integer; cdecl;
  sim_canny: function(src: Pointer; dst: pPointer; Threshold1: RealType;
    Threshold2: RealType; apertureSize: integer; L2gradient: boolean)
    : integer; cdecl;
  sim_cornerHarris: function(src: Pointer; dst: pPointer; blocksize: integer;
    ksize: integer; k: RealType): integer; cdecl;
  sim_dilate: function(src: Pointer; dst: pPointer; blocksize: integer;
    ksize: integer; kshape: integer): integer; cdecl;
  sim_erode: function(src: Pointer; dst: pPointer; blocksize: integer;
    ksize: integer; kshape: integer): integer; cdecl;
  sim_roi: function(src: Pointer; dst: pPointer; roix: integer; roiy: integer;
    roiw: integer; roih: integer): integer; cdecl;
  sim_split: function(src: Pointer; dst1: pPointer; dst2: pPointer;
    dst3: pPointer): integer; cdecl;
  sim_inRange: function(src: Pointer; dst: pPointer; lower: RealType;
    upper: RealType): integer; cdecl;
  sim_merge: function(src1: Pointer; src2: Pointer; src3: Pointer;
    dst: pPointer): integer; cdecl;
  sim_sobel: function(src: Pointer; dst: pPointer; dx: integer; dy: integer;
    ksize: integer; scale: RealType; delta: RealType): integer; cdecl;
  sim_scharr: function(src: Pointer; dst: pPointer; dx: integer; dy: integer;
    scale: RealType; delta: RealType): integer; cdecl;
  sim_laplacian: function(src: Pointer; dst: pPointer; ksize: integer;
    scale: RealType; delta: RealType): integer; cdecl;
  sim_resize: function(src: Pointer; dst: pPointer; ksizeX: integer;
    ksizeY: integer): integer; cdecl;
  sim_resizeP: function(src: Pointer; dst: pPointer; ksizeX: integer;
    ksizeY: integer; interpolation: integer): integer; cdecl;
  sim_warpPerspective: function(src: Pointer; dst: pPointer; srcPts: Pointer;
    dstPts: Pointer; dsizeX: integer; dsizeY: integer): integer; cdecl;
  sim_floodFill: function(src: Pointer; dst: pPointer; px: integer; py: integer;
    ch1: integer; ch2: integer; ch3: integer): integer; cdecl;

implementation

uses math;

/// /////////////////////////////////////////////////////////////////////////
/// //                                   TFRAMESOURCE                  //////
/// /////////////////////////////////////////////////////////////////////////

function TFRAMESOURCE.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'source') then
    begin
      Result := NativeInt(@sourceName);
      DataType := dtString;
    end

  end
end;

function TFRAMESOURCE.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TFRAMESOURCE.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        res := openVideoSource(@source, sourceName);
        Result := 0;
      end;

    f_GoodStep:
      begin
        if res = 0 then
        begin
          res := retrieveImage(source, @frame);
          if res = 0 then
          begin
            pPointer(@Y[0].Arr^[0])^ := frame;
          end
          else
          begin
            pPointer(@Y[0].Arr^[0])^ := nil;
          end;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@frame);
        releaseSourse(source);
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                        TIMREAD                  //////
/// /////////////////////////////////////////////////////////////////////////

function TIMREAD.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'source') then
    begin
      Result := NativeInt(@sourceName);
      DataType := dtString;
    end

  end
end;

function TIMREAD.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TIMREAD.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        frame := pPointer(@U[0].Arr^[0])^;
        res := openImage(@frame, sourceName, code);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := frame;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
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

/// /////////////////////////////////////////////////////////////////////////
/// //                                        TIMSHOW                  //////
/// /////////////////////////////////////////////////////////////////////////

function TIMSHOW.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'windowName') then
    begin
      Result := NativeInt(@windowName);
      DataType := dtString;
    end

    else

      if StrEqu(ParamName, 'delay') then
    begin
      Result := NativeInt(@delay);
      DataType := dtInteger;
    end

  end
end;

function TIMSHOW.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        createHandledWindow(windowName);
        Result := 0;
      end;

    f_GoodStep:
      begin
        frame := pPointer(@U[0].Arr^[0])^;
        res := showFrame(frame, delay, windowName);
      end;

    f_Stop:
      begin
        destroyWindowByName(windowName);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                  TCONVERTCOLOR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TCONVERTCOLOR.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'code') then
    begin
      Result := NativeInt(@code);
      DataType := dtInteger;
    end

  end
end;

function TCONVERTCOLOR.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TCONVERTCOLOR.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
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
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                    TBITWISEAND                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISEAND.GetParamID;
begin
  Result := -1;
end;

function TBITWISEAND.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISEAND.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin

        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;
    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        res := bitwiseAND(src1, src2, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TBITWISEOR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISEOR.GetParamID;
begin
  Result := -1;
end;

function TBITWISEOR.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISEOR.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;
    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;

        res := bitwiseOR(src1, src2, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;

      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TBITWISENO                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISENO.GetParamID;
begin
  Result := -1;
end;

function TBITWISENO.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISENO.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := bitwiseNO(src, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                    TBITWISEXOR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISEXOR.GetParamID;
begin
  Result := -1;
end;

function TBITWISEXOR.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISEXOR.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        res := bitwiseXOR(src1, src2, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TmatrixMUL                  //////
/// /////////////////////////////////////////////////////////////////////////

function TmatrixMUL.GetParamID;
begin
  Result := -1;
end;

function TmatrixMUL.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TmatrixMUL.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;
    f_GoodStep:
      begin

        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        res := matrixMUL(src1, src2, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;

      end;
    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                           TperElementAddWeighted                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementAddWeighted.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'alpha') then
    begin
      Result := NativeInt(@alpha);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'beta') then
    begin
      Result := NativeInt(@beta);
      DataType := dtDouble;
    end

  end
end;

function TperElementAddWeighted.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementAddWeighted.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        res := perElementAddWeighted(src1, alpha, src2, beta, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;

      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                 TperElementDIV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TABSDIFF.GetParamID;
begin
  Result := -1;
end;

function TABSDIFF.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TABSDIFF.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        res := absDiff(src1, src2, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                 TperElementMUL                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementMUL.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin
    if StrEqu(ParamName, 'scale') then
    begin
      Result := NativeInt(@scale);
      DataType := dtDouble;
    end
  end
end;

function TperElementMUL.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementMUL.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        res := perElementMUL(scale, src1, src2, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                TperElementADDV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementADD.GetParamID;
begin
  Result := -1;
end;

function TperElementADD.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementADD.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        res := perElementADD(src1, src2, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                TperElementADDV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementADDV.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin
    if StrEqu(ParamName, 'Value') then
    begin
      Result := NativeInt(@Value);
      DataType := dtDouble;
    end
  end
end;

function TperElementADDV.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementADDV.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := perElementADDV(src, Value, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                TperElementMULV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementMULV.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin
    if StrEqu(ParamName, 'Value') then
    begin
      Result := NativeInt(@Value);
      DataType := dtDouble;
    end
  end
end;

function TperElementMULV.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementMULV.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := perElementMULV(src, Value, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                      TTRESHOLD                  //////
/// /////////////////////////////////////////////////////////////////////////

function TTRESHOLD.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'Thresh') then
    begin
      Result := NativeInt(@Thresh);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'Maxval') then
    begin
      Result := NativeInt(@Maxval);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'codetype') then
    begin
      Result := NativeInt(@codetype);
      DataType := dtInteger;
    end

  end
end;

function TTRESHOLD.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TTRESHOLD.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_threshold(src, @dst, Thresh, Maxval, codetype);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                             TADAPTIVETHRESHOLD                  //////
/// /////////////////////////////////////////////////////////////////////////

function TADAPTIVETHRESHOLD.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin
    if StrEqu(ParamName, 'maxValue') then
    begin
      Result := NativeInt(@maxValue);
      DataType := dtDouble;
    end
    else if StrEqu(ParamName, 'adaptiveMethod') then
    begin
      Result := NativeInt(@adaptiveMethod);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'ThresholdType') then
    begin
      Result := NativeInt(@ThresholdType);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'blocksize') then
    begin
      Result := NativeInt(@blocksize);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'C') then
    begin
      Result := NativeInt(@C);
      DataType := dtDouble;
    end
  end
end;

function TADAPTIVETHRESHOLD.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TADAPTIVETHRESHOLD.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_adaptiveThreshold(src, @dst, maxValue, adaptiveMethod,
          ThresholdType, blocksize, C);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                               TBILATERALFILTER                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBILATERALFILTER.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin
    if StrEqu(ParamName, 'd') then
    begin
      Result := NativeInt(@d);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'SigmaColor') then
    begin
      Result := NativeInt(@SigmaColor);
      DataType := dtDouble;
    end
    else if StrEqu(ParamName, 'SigmaSpace') then
    begin
      Result := NativeInt(@SigmaSpace);
      DataType := dtDouble;
    end
  end
end;

function TBILATERALFILTER.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBILATERALFILTER.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_bilateralFilter(src, @dst, d, SigmaColor, SigmaSpace);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                          TBLUR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBLUR.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      Result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      Result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

  end
end;

function TBLUR.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBLUR.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;
    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_blur(src, @dst, ksizeX, ksizeY);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                  TGAUSSIANBLUR                  //////
/// /////////////////////////////////////////////////////////////////////////
function TGAUSSIANBLUR.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      Result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      Result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'sigmaX') then
    begin
      Result := NativeInt(@sigmaX);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'sigmaY') then
    begin
      Result := NativeInt(@sigmaY);
      DataType := dtDouble;
    end

  end
end;

function TGAUSSIANBLUR.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TGAUSSIANBLUR.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_gaussianBlur(src, @dst, ksizeX, ksizeY, sigmaX, sigmaY);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TBOXFILTER                  //////
/// /////////////////////////////////////////////////////////////////////////
function TBOXFILTER.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      Result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      Result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'anchorX') then
    begin
      Result := NativeInt(@anchorX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'anchorY') then
    begin
      Result := NativeInt(@anchorY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'normalize') then
    begin
      Result := NativeInt(@normalize);
      DataType := dtInteger;
    end

  end
end;

function TBOXFILTER.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBOXFILTER.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_boxFilter(src, @dst, ksizeX, ksizeY, anchorX, anchorY,
          normalize);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TCANNY                  //////
/// /////////////////////////////////////////////////////////////////////////

function TCANNY.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'Threshold1') then
    begin
      Result := NativeInt(@Threshold1);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'Threshold2') then
    begin
      Result := NativeInt(@Threshold2);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'apertureSize') then
    begin
      Result := NativeInt(@apertureSize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'L2gradient') then
    begin
      Result := NativeInt(@L2gradient);
      DataType := dtBool;
    end

  end
end;

function TCANNY.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TCANNY.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_canny(src, @dst, Threshold1, Threshold2, apertureSize,
          L2gradient);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                  TCORNERHARRIS                  //////
/// /////////////////////////////////////////////////////////////////////////
function TCORNERHARRIS.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'blocksize') then
    begin
      Result := NativeInt(@blocksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksize') then
    begin
      Result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'k') then
    begin
      Result := NativeInt(@k);
      DataType := dtDouble;
    end

  end
end;

function TCORNERHARRIS.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TCORNERHARRIS.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_cornerHarris(src, @dst, blocksize, ksize, k);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                        TDILATE                  //////
/// /////////////////////////////////////////////////////////////////////////
function TDILATE.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'blocksize') then
    begin
      Result := NativeInt(@blocksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksize') then
    begin
      Result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'kshape') then
    begin
      Result := NativeInt(@kshape);
      DataType := dtInteger;
    end

  end
end;

function TDILATE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TDILATE.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_dilate(src, @dst, blocksize, ksize, integer(kshape));
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TERODE                  //////
/// /////////////////////////////////////////////////////////////////////////
function TERODE.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'blocksize') then
    begin
      Result := NativeInt(@blocksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksize') then
    begin
      Result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'kShape') then
    begin
      Result := NativeInt(@kshape);
      DataType := dtInteger;
    end

  end
end;

function TERODE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TERODE.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;
    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_erode(src, @dst, blocksize, ksize, integer(kshape));
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                           TROI                  //////
/// /////////////////////////////////////////////////////////////////////////

function TROI.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'roix') then
    begin
      Result := NativeInt(@roix);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'roiy') then
    begin
      Result := NativeInt(@roiy);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'roiw') then
    begin
      Result := NativeInt(@roiw);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'roih') then
    begin
      Result := NativeInt(@roih);
      DataType := dtInteger;
    end

  end
end;

function TROI.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TROI.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_roi(src, @dst, roix, roiy, roiw, roih);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TSPLIT                  //////
/// /////////////////////////////////////////////////////////////////////////

function TSPLIT.GetParamID;
begin
  Result := -1;
end;

function TSPLIT.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSPLIT.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_split(src, @dst1, @dst2, @dst3);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst1;
          pPointer(@Y[1].Arr^[0])^ := dst2;
          pPointer(@Y[2].Arr^[0])^ := dst3;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          pPointer(@Y[1].Arr^[0])^ := nil;
          pPointer(@Y[2].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst1);
        releaseSimMat(@dst2);
        releaseSimMat(@dst3);
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                       TINRANGE                  //////
/// /////////////////////////////////////////////////////////////////////////

function TINRANGE.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'lower') then
    begin
      Result := NativeInt(@lower);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'upper') then
    begin
      Result := NativeInt(@upper);
      DataType := dtDouble;
    end

  end
end;

function TINRANGE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TINRANGE.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_inRange(src, @dst, lower, upper);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TMERGE                  //////
/// /////////////////////////////////////////////////////////////////////////

function TMERGE.GetParamID;
begin
  Result := -1;
end;

function TMERGE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TMERGE.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src1 := pPointer(@U[0].Arr^[0])^;
        src2 := pPointer(@U[1].Arr^[0])^;
        src3 := pPointer(@U[2].Arr^[0])^;
        res := sim_merge(src1, src2, src3, @dst);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TSOBEL                  //////
/// /////////////////////////////////////////////////////////////////////////

function TSOBEL.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'dx') then
    begin
      Result := NativeInt(@dx);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'dy') then
    begin
      Result := NativeInt(@dy);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksize') then
    begin
      Result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'scale') then
    begin
      Result := NativeInt(@scale);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'delta') then
    begin
      Result := NativeInt(@delta);
      DataType := dtDouble;
    end

  end
end;

function TSOBEL.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSOBEL.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;
    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_sobel(src, @dst, dx, dy, ksize, scale, delta);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                        TSCHARR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TSCHARR.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'dx') then
    begin
      Result := NativeInt(@dx);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'dy') then
    begin
      Result := NativeInt(@dy);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'scale') then
    begin
      Result := NativeInt(@scale);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'delta') then
    begin
      Result := NativeInt(@delta);
      DataType := dtDouble;
    end

  end
end;

function TSCHARR.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSCHARR.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_scharr(src, @dst, dx, dy, scale, delta);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TLAPLACIAN                  //////
/// /////////////////////////////////////////////////////////////////////////

function TLAPLACIAN.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'ksize') then
    begin
      Result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'scale') then
    begin
      Result := NativeInt(@scale);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'delta') then
    begin
      Result := NativeInt(@delta);
      DataType := dtDouble;
    end

  end
end;

function TLAPLACIAN.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TLAPLACIAN.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_laplacian(src, @dst, ksize, scale, delta);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                        TRESIZE                  //////
/// /////////////////////////////////////////////////////////////////////////

function TRESIZE.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      Result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizey') then
    begin
      Result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

  end
end;

function TRESIZE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TRESIZE.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_resize(src, @dst, ksizeX, ksizeY);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                       TRESIZEP                  //////
/// /////////////////////////////////////////////////////////////////////////
function TRESIZEP.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      Result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      Result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'interpolation') then
    begin
      Result := NativeInt(@interpolation);
      DataType := dtInteger;
    end

  end
end;

function TRESIZEP.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TRESIZEP.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_resizeP(src, @dst, ksizeX, ksizeY, interpolation);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                               TwarpPerspective                  //////
/// /////////////////////////////////////////////////////////////////////////

function TwarpPerspective.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'dsizeX') then
    begin
      Result := NativeInt(@dsizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'dsizeY') then
    begin
      Result := NativeInt(@dsizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'srcX1') then
    begin
      Result := NativeInt(@srcPts[1]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY1') then
    begin
      Result := NativeInt(@srcPts[2]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcX2') then
    begin
      Result := NativeInt(@srcPts[3]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY2') then
    begin
      Result := NativeInt(@srcPts[4]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcX3') then
    begin
      Result := NativeInt(@srcPts[5]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY3') then
    begin
      Result := NativeInt(@srcPts[6]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcX4') then
    begin
      Result := NativeInt(@srcPts[7]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY4') then
    begin
      Result := NativeInt(@srcPts[8]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX1') then
    begin
      Result := NativeInt(@dstPts[1]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY1') then
    begin
      Result := NativeInt(@dstPts[2]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX2') then
    begin
      Result := NativeInt(@dstPts[3]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY2') then
    begin
      Result := NativeInt(@dstPts[4]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX3') then
    begin
      Result := NativeInt(@dstPts[5]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY3') then
    begin
      Result := NativeInt(@dstPts[6]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX4') then
    begin
      Result := NativeInt(@dstPts[7]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY4') then
    begin
      Result := NativeInt(@dstPts[8]);
      DataType := dtDouble;
    end

  end
end;

function TwarpPerspective.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TwarpPerspective.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of

    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_warpPerspective(src, @dst, @srcPts[1], @dstPts[1],
          dsizeX, dsizeY);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                    TFloodFill                  //////
/// /////////////////////////////////////////////////////////////////////////

function TFloodFill.GetParamID;
begin
  Result := inherited GetParamID(ParamName, DataType, IsConst);
  if Result = -1 then
  begin

    if StrEqu(ParamName, 'px') then
    begin
      Result := NativeInt(@px);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'py') then
    begin
      Result := NativeInt(@py);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ch1') then
    begin
      Result := NativeInt(@ch1);
      DataType := dtInteger;
    end
    else

      if StrEqu(ParamName, 'ch2') then
    begin
      Result := NativeInt(@ch2);
      DataType := dtInteger;
    end
    else

      if StrEqu(ParamName, 'ch3') then
    begin
      Result := NativeInt(@ch3);
      DataType := dtInteger;
    end

  end
end;

function TFloodFill.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  Result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        Result := 1;
      end;
  else
    Result := inherited InfoFunc(Action, aParameter);
  end
end;

function TFloodFill.RunFunc;
var
  res: integer;
begin
  Result := 0;
  case Action of
    f_InitState:
      begin
        Result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_floodFill(src, @dst, px, py, ch1, ch2, ch3);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dst;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@dst);
        Result := 0;
      end;

  end
end;
// ***********************************************************************//
// Раздел инициализации                               //
// ***********************************************************************//

var
  hDll: THandle;

initialization

hDll := LoadLibrary('simintechVisLib.dll');

createHandledWindow := GetProcAddress(hDll, 'createHandledWindow');
getWindowHandle := GetProcAddress(hDll, 'getWindowHandle');
// Получить изображение из источника
retrieveImage := GetProcAddress(hDll, 'retrieveImage');
// Очистка ресурсов
releaseSimMat := GetProcAddress(hDll, 'releaseSimMat');
releaseSourse := GetProcAddress(hDll, 'releaseSourse');
destroyWindowByName := GetProcAddress(hDll, 'destroyWindowByName');
destroyAllWindows := GetProcAddress(hDll, 'destroyAllWindows');
// Открыть источник изображений
openVideoSource := GetProcAddress(hDll, 'openVideoSource');
// Открыть изображение из файла
openImage := GetProcAddress(hDll, 'openImage');
// Показать изображение
showFrame := GetProcAddress(hDll, 'showFrame');
sim_convertColor := GetProcAddress(hDll, 'sim_convertColor');
bitwiseAND := GetProcAddress(hDll, 'bitwiseAND');
bitwiseOR := GetProcAddress(hDll, 'bitwiseOR');
bitwiseNO := GetProcAddress(hDll, 'bitwiseNO');
bitwiseXOR := GetProcAddress(hDll, 'bitwiseXOR');
matrixMUL := GetProcAddress(hDll, 'matrixMUL');
perElementAddWeighted := GetProcAddress(hDll, 'perElementAddWeighted');
absDiff := GetProcAddress(hDll, 'absDiff');
perElementMUL := GetProcAddress(hDll, 'perElementMUL');
perElementADDV := GetProcAddress(hDll, 'perElementADDV');
perElementADD := GetProcAddress(hDll, 'perElementADD');
perElementMULV := GetProcAddress(hDll, 'perElementMULV');
sim_threshold := GetProcAddress(hDll, 'sim_threshold');
sim_adaptiveThreshold := GetProcAddress(hDll, 'sim_adaptiveThreshold');
sim_bilateralFilter := GetProcAddress(hDll, 'sim_bilateralFilter');
sim_blur := GetProcAddress(hDll, 'sim_blur');
sim_gaussianBlur := GetProcAddress(hDll, 'sim_gaussianBlur');
sim_boxFilter := GetProcAddress(hDll, 'sim_boxFilter');
sim_canny := GetProcAddress(hDll, 'sim_canny');
sim_cornerHarris := GetProcAddress(hDll, 'sim_cornerHarris');
sim_dilate := GetProcAddress(hDll, 'sim_dilate');
sim_erode := GetProcAddress(hDll, 'sim_erode');
sim_roi := GetProcAddress(hDll, 'sim_roi');
sim_split := GetProcAddress(hDll, 'sim_split');
sim_inRange := GetProcAddress(hDll, 'sim_inRange');
sim_merge := GetProcAddress(hDll, 'sim_merge');
sim_sobel := GetProcAddress(hDll, 'sim_sobel');
sim_scharr := GetProcAddress(hDll, 'sim_scharr');
sim_laplacian := GetProcAddress(hDll, 'sim_laplacian');
sim_resize := GetProcAddress(hDll, 'sim_resize');
sim_resizeP := GetProcAddress(hDll, 'sim_resizeP');
sim_warpPerspective := GetProcAddress(hDll, 'sim_warpPerspective');
sim_floodFill := GetProcAddress(hDll, 'sim_floodFill');

finalization

if hDll <> 0 then
  FreeLibrary(hDll);

end.
