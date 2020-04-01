// ErrorEvent('1!!!', msError, VisualObject);
unit Blocks;

interface

uses Windows, Classes, DataTypes, SysUtils, RunObjts, uExtMath, IntArrays;

type
  pPointer = ^Pointer;
  TConversionType = (COLOR_BGR2BGRA, // 0,
    COLOR_RGB2RGBA, // 0,
    COLOR_BGRA2BGR, // 1,
    COLOR_RGBA2RGB, // 1,
    COLOR_BGR2RGBA, // 2,
    COLOR_RGB2BGRA, // 2,
    COLOR_RGBA2BGR, // 3,
    COLOR_BGRA2RGB, // 3,
    COLOR_BGR2RGB, // 4,
    COLOR_RGB2BGR, // 4,
    COLOR_BGRA2RGBA, // 5,
    COLOR_RGBA2BGRA, // 5,
    COLOR_BGR2GRAY, // 6,
    COLOR_RGB2GRAY, // 7,
    COLOR_GRAY2BGR, // 8,
    COLOR_GRAY2RGB, // 8,
    COLOR_BGR2HSV, // 40,
    COLOR_RGB2HSV, // 41,
    // COLOR_BGR2HLS, // 52,
    // COLOR_RGB2HLS, // 53,
    COLOR_HSV2BGR, // 54,
    COLOR_HSV2RGB // 55
    // COLOR_HLS2BGR, // 60,
    // COLOR_HLS2RGB // 61,
    );
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
    code: NativeInt;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TIMSEQREAD = class(TRunObject)
  public
    fileList: tStringList;
    frame: Pointer;
    sourceMask: String;
    sourcePath: String;
    counter: NativeInt;
    code: NativeInt;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TIMSHOW = class(TRunObject)
  public
    windowName: String;
    delay: NativeInt;
    frame: Pointer;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TCONVERTCOLOR = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    code: NativeInt;
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
    codetype: NativeInt;
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
    adaptiveMethod: NativeInt;
    ThresholdType: NativeInt;
    blocksize: NativeInt;
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
    d: NativeInt;
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
    ksizeX: NativeInt;
    ksizeY: NativeInt;
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
    ksizeX: NativeInt;
    ksizeY: NativeInt;
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
    ksizeX: NativeInt;
    ksizeY: NativeInt;
    anchorX: NativeInt;
    anchorY: NativeInt;
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
    apertureSize: NativeInt;
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
    blocksize: NativeInt;
    ksize: NativeInt;
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
    ksize: NativeInt;
    kshape: NativeInt;
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
    ksize: NativeInt;
    kshape: NativeInt;
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
    roix: NativeInt;
    roiy: NativeInt;
    roiw: NativeInt;
    roih: NativeInt;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TFLIP = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    code: NativeInt;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TROTATE = class(TRunObject)
  public
    src: Pointer;
    dst: Pointer;
    code: NativeInt;
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
    dx: NativeInt;
    dy: NativeInt;
    ksize: NativeInt;
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
    dx: NativeInt;
    dy: NativeInt;
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
    ksize: NativeInt;
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
    ksizeX: NativeInt;
    ksizeY: NativeInt;
    fx: RealType;
    fy: RealType;
    interpolation: integer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TCalibrateCamera = class(TRunObject)
  public
    image: Pointer;
    image_points: Pointer;
    object_points: Pointer;
    dstImage: Pointer;
    intrinsic: Pointer;
    distCoeffs: Pointer;
    numCornersHor: NativeInt;
    numCornersVer: NativeInt;
    fileName: String;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TLoadCalibrationParameters = class(TRunObject)
  public
    intrinsic: Pointer;
    distCoeffs: Pointer;
    fileName: String;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TUndistotImage = class(TRunObject)
  public
    intrinsic: Pointer;
    distCoeffs: Pointer;
    src: Pointer;
    dst: Pointer;
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
    dsizeX: NativeInt;
    dsizeY: NativeInt;
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
    px: NativeInt;
    py: NativeInt;
    ch1: NativeInt;
    ch2: NativeInt;
    ch3: NativeInt;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TFindContous = class(TRunObject)
  public
    srcFrame: Pointer;
    contours: Pointer;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
  end;

  TSelectContour = class(TRunObject)
  public
    srcFrame: Pointer;
    dstFrame: Pointer;
    contours: Pointer;
    contour: Pointer;
    index: NativeInt;
    width: NativeInt;
    red: NativeInt;
    green: NativeInt;
    blue: NativeInt;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TSelectContourArea = class(TRunObject)
  public
    inputContours: Pointer;
    outputContours: Pointer;
    minArea: Double;
    maxArea: Double;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TFindSign = class(TRunObject)
  public
    templFrame: Pointer;
    templContour: Pointer;
    frame: Pointer;
    contours: Pointer;
    normalizedContourSizeX: NativeInt;
    normalizedContourSizeY: NativeInt;
    useHull: NativeInt;
    draw: NativeInt;
    minCorrelation: RealType;
    numFound: NativeInt;
    function InfoFunc(Action: integer; aParameter: NativeInt)
      : NativeInt; override;
    function RunFunc(var at, h: RealType; Action: integer): NativeInt; override;
    function GetParamID(const ParamName: string; var DataType: TDataType;
      var IsConst: boolean): NativeInt; override;
  end;

  TDetectLanes = class(TRunObject)
  public
    binaryinput: Pointer;
    drawinput: Pointer;
    rd: NativeInt;
    ld: NativeInt;
    numHorHist: NativeInt;
    wheel: NativeInt;
    roi: NativeInt;
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
  sim_dilate: function(src: Pointer; dst: pPointer; ksize: integer;
    kshape: integer): integer; cdecl;
  sim_erode: function(src: Pointer; dst: pPointer; ksize: integer;
    kshape: integer): integer; cdecl;
  sim_roi: function(src: Pointer; dst: pPointer; roix: integer; roiy: integer;
    roiw: integer; roih: integer): integer; cdecl;
  sim_flip: function(src: Pointer; dst: pPointer; code: integer)
    : integer; cdecl;
  sim_rotate: function(src: Pointer; dst: pPointer; code: integer)
    : integer; cdecl;
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
    ksizeY: integer; interpolation: integer): integer; cdecl;
  sim_warpPerspective: function(src: Pointer; dst: pPointer; srcPts: Pointer;
    dstPts: Pointer; dsizeX: integer; dsizeY: integer): integer; cdecl;
  sim_floodFill: function(src: Pointer; dst: pPointer; px: integer; py: integer;
    ch1: integer; ch2: integer; ch3: integer): integer; cdecl;

  sim_findContours: function(srcImage: Pointer; contours: pPointer)
    : integer; cdecl;

  sim_selectContour: function(srcImage: Pointer; contours: Pointer;
    index: integer; red: integer; green: integer; blue: integer; width: integer;
    dstItmage: pPointer; result: pPointer): integer; cdecl;
  sim_minMaxAreaContoursFilter: function(src: Pointer; dst: pPointer;
    min: Pointer; max: Pointer): integer; cdecl;
  sim_fidnCalibrationPoints: function(image_points: pPointer;
    object_points: pPointer; image: Pointer; dst: pPointer;
    numCornersHor: integer; numCornersVer: integer): integer; cdecl;

  sim_undistort: function(image: Pointer; imageUndistorted: pPointer;
    intrinsic: Pointer; distCoeffs: Pointer): integer; cdecl;
  sim_calibrateCamera: function(image_points: Pointer; object_points: Pointer;
    image: Pointer; intrinsic: pPointer; distCoeffs: pPointer): integer; cdecl;
  sim_saveCalibrationParameters: function(name: AnsiString; intrinsic: Pointer;
    distCoeffs: Pointer): integer; cdecl;
  sim_loadCalibrationParameters: function(name: AnsiString; intrinsic: pPointer;
    distCoeffs: pPointer): integer; cdecl;

  sim_findSign: function(templFrame: Pointer; templContour: Pointer;
    frame: Pointer; contours: Pointer; normalizedContourSizeX: integer;
    normalizedContourSizeY: integer; useHull: NativeInt; draw: NativeInt;
    minCorrelation: RealType; numFound: Pointer): integer; cdecl;

  sim_detectLanes: function(binaryinput: Pointer; numHorHist: integer;
    roi_w: integer; wheel_h: integer; rd: Pointer; ld: Pointer;
    drawinput: Pointer): integer; cdecl;

implementation

uses math, Masks;

procedure SearchInDir(Mask, Dir: string; Subdir: boolean;
  var List: tStringList);
var
  r: integer;
  f: TSearchRec;
begin
  if Dir = '' then
    Exit;
  if Dir[Length(Dir)] <> '\' then
    Dir := Dir + '\';
{$I-}
  ChDir(Dir);
{$I+}
  if IOResult <> 0 then
    Exit;
  r := FindFirst('*.*', faAnyFile, f);
  while r = 0 do
  begin
    IF ((f.Attr and faDirectory) <> faDirectory) THEN
      if (MatchesMask(f.Name, Mask)) or (Mask = '*.*') then
        if (f.Name <> '.') and (f.Name <> '..') then
          List.Add(ExpandFileName(f.Name));
    if (f.Attr and faDirectory) = faDirectory then
      if Subdir = True then
      begin
        if (f.Name <> '.') and (f.Name <> '..') then
        begin
          SearchInDir(Mask, ExpandFileName(f.Name), Subdir, List);
          ChDir(Dir);
        end;
      end;
    r := FindNext(f);
  end;
  FindClose(f);
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                   TFRAMESOURCE                  //////
/// /////////////////////////////////////////////////////////////////////////

function TFRAMESOURCE.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'source') then
    begin
      result := NativeInt(@sourceName);
      DataType := dtString;
    end

  end
end;

function TFRAMESOURCE.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TFRAMESOURCE.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        res := openVideoSource(@source, sourceName);
        result := 0;
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
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'source') then
    begin
      result := NativeInt(@sourceName);
      DataType := dtString;
    end
    else if StrEqu(ParamName, 'code') then
    begin
      result := NativeInt(@code);
      DataType := dtInteger;
    end
  end
end;

function TIMREAD.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TIMREAD.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
        res := 0;
      end;

    f_GoodStep:
      begin
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
        releaseSimMat(@frame);
      end;

  end
end;
/// /////////////////////////////////////////////////////////////////////////
/// //                                        TIMSEQREAD                  //////
/// /////////////////////////////////////////////////////////////////////////

function TIMSEQREAD.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'path') then
    begin
      result := NativeInt(@sourcePath);
      DataType := dtString;
    end
    else if StrEqu(ParamName, 'mask') then
    begin
      result := NativeInt(@sourceMask);
      DataType := dtString;
    end
    else if StrEqu(ParamName, 'code') then
    begin
      result := NativeInt(@code);
      DataType := dtInteger;
    end
  end
end;

function TIMSEQREAD.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TIMSEQREAD.RunFunc;
var
  res, tmp: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        fileList := tStringList.Create;
        SearchInDir(sourceMask, sourcePath, True, fileList);
        for tmp := 0 to fileList.Count - 1 do
          ErrorEvent(fileList[tmp], msInfo, VisualObject);
        result := 0;
        counter := 0;
        res := 0;
      end;

    f_GoodStep:
      begin
        if (counter < fileList.Count) and (fileList.Count > 0) then
        begin
          res := openImage(@frame, fileList[counter], code);
          counter := counter + 1;
          // ErrorEvent(IntToStr(counter), msError, VisualObject);
          if res = 0 then
          begin
            pPointer(@Y[0].Arr^[0])^ := frame;
          end
          else
          begin
            pPointer(@Y[0].Arr^[0])^ := nil;
          end;
        end;
      end;

    f_Stop:
      begin
        releaseSimMat(@frame);
      end;

  end
end;
/// /////////////////////////////////////////////////////////////////////////
/// //                                        TIMSHOW                  //////
/// /////////////////////////////////////////////////////////////////////////

function TIMSHOW.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'windowName') then
    begin
      result := NativeInt(@windowName);
      DataType := dtString;
    end

    else

      if StrEqu(ParamName, 'delay') then
    begin
      result := NativeInt(@delay);
      DataType := dtInteger;
    end

  end
end;

function TIMSHOW.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        createHandledWindow(windowName);
        result := 0;
      end;

    f_GoodStep:
      begin
        frame := pPointer(@U[0].Arr^[0])^;
        res := showFrame(frame, delay, windowName);
      end;

    f_Stop:
      begin
        destroyWindowByName(windowName);
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                  TCONVERTCOLOR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TCONVERTCOLOR.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'code') then
    begin
      result := NativeInt(@code);
      DataType := dtInteger;
    end

  end
end;

function TCONVERTCOLOR.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TCONVERTCOLOR.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
      end;
    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        Case code of
          integer(COLOR_BGR2BGRA):
            res := sim_convertColor(src, @dst, 0);
          integer(COLOR_RGB2RGBA):
            res := sim_convertColor(src, @dst, 0);
          integer(COLOR_BGRA2BGR):
            res := sim_convertColor(src, @dst, 1);
          integer(COLOR_RGBA2RGB):
            res := sim_convertColor(src, @dst, 1);
          integer(COLOR_BGR2RGBA):
            res := sim_convertColor(src, @dst, 2);
          integer(COLOR_RGB2BGRA):
            res := sim_convertColor(src, @dst, 2);
          integer(COLOR_RGBA2BGR):
            res := sim_convertColor(src, @dst, 3);
          integer(COLOR_BGRA2RGB):
            res := sim_convertColor(src, @dst, 3);
          integer(COLOR_BGR2RGB):
            res := sim_convertColor(src, @dst, 4);
          integer(COLOR_RGB2BGR):
            res := sim_convertColor(src, @dst, 4);
          integer(COLOR_BGRA2RGBA):
            res := sim_convertColor(src, @dst, 5);
          integer(COLOR_RGBA2BGRA):
            res := sim_convertColor(src, @dst, 5);
          integer(COLOR_BGR2GRAY):
            res := sim_convertColor(src, @dst, 6);
          integer(COLOR_RGB2GRAY):
            res := sim_convertColor(src, @dst, 7);
          integer(COLOR_GRAY2BGR):
            res := sim_convertColor(src, @dst, 8);
          integer(COLOR_GRAY2RGB):
            res := sim_convertColor(src, @dst, 8);
          integer(COLOR_BGR2HSV):
            res := sim_convertColor(src, @dst, 40);
          integer(COLOR_RGB2HSV):
            res := sim_convertColor(src, @dst, 41);
          {
            integer(COLOR_BGR2HLS):
            res := sim_convertColor(src, @dst, 52);
            integer(COLOR_RGB2HLS):
            res := sim_convertColor(src, @dst, 53);
          }
          integer(COLOR_HSV2BGR):
            res := sim_convertColor(src, @dst, 54);
          integer(COLOR_HSV2RGB):
            res := sim_convertColor(src, @dst, 55);
          {
            integer(COLOR_HLS2BGR):
            res := sim_convertColor(src, @dst, 54);
            integer(COLOR_HLS2RGB):
            res := sim_convertColor(src, @dst, 55);
          }
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                    TBITWISEAND                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISEAND.GetParamID;
begin
  result := -1;
end;

function TBITWISEAND.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISEAND.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin

        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TBITWISEOR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISEOR.GetParamID;
begin
  result := -1;
end;

function TBITWISEOR.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISEOR.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TBITWISENO                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISENO.GetParamID;
begin
  result := -1;
end;

function TBITWISENO.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISENO.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                    TBITWISEXOR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBITWISEXOR.GetParamID;
begin
  result := -1;
end;

function TBITWISEXOR.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBITWISEXOR.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TmatrixMUL                  //////
/// /////////////////////////////////////////////////////////////////////////

function TmatrixMUL.GetParamID;
begin
  result := -1;
end;

function TmatrixMUL.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TmatrixMUL.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                           TperElementAddWeighted                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementAddWeighted.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'alpha') then
    begin
      result := NativeInt(@alpha);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'beta') then
    begin
      result := NativeInt(@beta);
      DataType := dtDouble;
    end

  end
end;

function TperElementAddWeighted.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementAddWeighted.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                 TperElementDIV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TABSDIFF.GetParamID;
begin
  result := -1;
end;

function TABSDIFF.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TABSDIFF.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                 TperElementMUL                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementMUL.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'scale') then
    begin
      result := NativeInt(@scale);
      DataType := dtDouble;
    end
  end
end;

function TperElementMUL.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementMUL.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                TperElementADDV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementADD.GetParamID;
begin
  result := -1;
end;

function TperElementADD.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementADD.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                TperElementADDV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementADDV.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'Value') then
    begin
      result := NativeInt(@Value);
      DataType := dtDouble;
    end
  end
end;

function TperElementADDV.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementADDV.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                TperElementMULV                  //////
/// /////////////////////////////////////////////////////////////////////////

function TperElementMULV.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'Value') then
    begin
      result := NativeInt(@Value);
      DataType := dtDouble;
    end
  end
end;

function TperElementMULV.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TperElementMULV.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        pPointer(@Y[0].Arr^[0])^ := nil;
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                      TTRESHOLD                  //////
/// /////////////////////////////////////////////////////////////////////////

function TTRESHOLD.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'Thresh') then
    begin
      result := NativeInt(@Thresh);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'Maxval') then
    begin
      result := NativeInt(@Maxval);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'codetype') then
    begin
      result := NativeInt(@codetype);
      DataType := dtInteger;
    end

  end
end;

function TTRESHOLD.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TTRESHOLD.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                             TADAPTIVETHRESHOLD                  //////
/// /////////////////////////////////////////////////////////////////////////

function TADAPTIVETHRESHOLD.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'maxValue') then
    begin
      result := NativeInt(@maxValue);
      DataType := dtDouble;
    end
    else if StrEqu(ParamName, 'adaptiveMethod') then
    begin
      result := NativeInt(@adaptiveMethod);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'ThresholdType') then
    begin
      result := NativeInt(@ThresholdType);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'blocksize') then
    begin
      result := NativeInt(@blocksize);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'C') then
    begin
      result := NativeInt(@C);
      DataType := dtDouble;
    end
  end
end;

function TADAPTIVETHRESHOLD.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TADAPTIVETHRESHOLD.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                               TBILATERALFILTER                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBILATERALFILTER.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'd') then
    begin
      result := NativeInt(@d);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'SigmaColor') then
    begin
      result := NativeInt(@SigmaColor);
      DataType := dtDouble;
    end
    else if StrEqu(ParamName, 'SigmaSpace') then
    begin
      result := NativeInt(@SigmaSpace);
      DataType := dtDouble;
    end
  end
end;

function TBILATERALFILTER.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBILATERALFILTER.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                          TBLUR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TBLUR.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

  end
end;

function TBLUR.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBLUR.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                  TGAUSSIANBLUR                  //////
/// /////////////////////////////////////////////////////////////////////////
function TGAUSSIANBLUR.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'sigmaX') then
    begin
      result := NativeInt(@sigmaX);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'sigmaY') then
    begin
      result := NativeInt(@sigmaY);
      DataType := dtDouble;
    end

  end
end;

function TGAUSSIANBLUR.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TGAUSSIANBLUR.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TBOXFILTER                  //////
/// /////////////////////////////////////////////////////////////////////////
function TBOXFILTER.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'anchorX') then
    begin
      result := NativeInt(@anchorX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'anchorY') then
    begin
      result := NativeInt(@anchorY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'normalize') then
    begin
      result := NativeInt(@normalize);
      DataType := dtInteger;
    end

  end
end;

function TBOXFILTER.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TBOXFILTER.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TCANNY                  //////
/// /////////////////////////////////////////////////////////////////////////

function TCANNY.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'Threshold1') then
    begin
      result := NativeInt(@Threshold1);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'Threshold2') then
    begin
      result := NativeInt(@Threshold2);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'apertureSize') then
    begin
      result := NativeInt(@apertureSize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'L2gradient') then
    begin
      result := NativeInt(@L2gradient);
      DataType := dtBool;
    end

  end
end;

function TCANNY.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TCANNY.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;
  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                  TCORNERHARRIS                  //////
/// /////////////////////////////////////////////////////////////////////////
function TCORNERHARRIS.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'blocksize') then
    begin
      result := NativeInt(@blocksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksize') then
    begin
      result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'k') then
    begin
      result := NativeInt(@k);
      DataType := dtDouble;
    end

  end
end;

function TCORNERHARRIS.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TCORNERHARRIS.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                        TDILATE                  //////
/// /////////////////////////////////////////////////////////////////////////
function TDILATE.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'ksize') then
    begin
      result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'kshape') then
    begin
      result := NativeInt(@kshape);
      DataType := dtInteger;
    end

  end
end;

function TDILATE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TDILATE.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_dilate(src, @dst, ksize, integer(kshape));
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TERODE                  //////
/// /////////////////////////////////////////////////////////////////////////
function TERODE.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'ksize') then
    begin
      result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'kShape') then
    begin
      result := NativeInt(@kshape);
      DataType := dtInteger;
    end

  end
end;

function TERODE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TERODE.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
      end;
    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_erode(src, @dst, ksize, integer(kshape));
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                           TROI                  //////
/// /////////////////////////////////////////////////////////////////////////

function TROI.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'roix') then
    begin
      result := NativeInt(@roix);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'roiy') then
    begin
      result := NativeInt(@roiy);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'roiw') then
    begin
      result := NativeInt(@roiw);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'roih') then
    begin
      result := NativeInt(@roih);
      DataType := dtInteger;
    end

  end
end;

function TROI.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TROI.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                           TROI                  //////
/// /////////////////////////////////////////////////////////////////////////

function TFLIP.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'code') then
    begin
      result := NativeInt(@code);
      DataType := dtInteger;
    end
  end
end;

function TFLIP.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TFLIP.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_flip(src, @dst, code);
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                       TROTATE                   //////
/// /////////////////////////////////////////////////////////////////////////

function TROTATE.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'code') then
    begin
      result := NativeInt(@code);
      DataType := dtInteger;
    end
  end
end;

function TROTATE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TROTATE.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_rotate(src, @dst, code);
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TSPLIT                  //////
/// /////////////////////////////////////////////////////////////////////////

function TSPLIT.GetParamID;
begin
  result := -1;
end;

function TSPLIT.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSPLIT.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'lower') then
    begin
      result := NativeInt(@lower);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'upper') then
    begin
      result := NativeInt(@upper);
      DataType := dtDouble;
    end

  end
end;

function TINRANGE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TINRANGE.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TMERGE                  //////
/// /////////////////////////////////////////////////////////////////////////

function TMERGE.GetParamID;
begin
  result := -1;
end;

function TMERGE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TMERGE.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                         TSOBEL                  //////
/// /////////////////////////////////////////////////////////////////////////

function TSOBEL.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'dx') then
    begin
      result := NativeInt(@dx);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'dy') then
    begin
      result := NativeInt(@dy);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksize') then
    begin
      result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'scale') then
    begin
      result := NativeInt(@scale);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'delta') then
    begin
      result := NativeInt(@delta);
      DataType := dtDouble;
    end

  end
end;

function TSOBEL.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSOBEL.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                        TSCHARR                  //////
/// /////////////////////////////////////////////////////////////////////////

function TSCHARR.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'dx') then
    begin
      result := NativeInt(@dx);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'dy') then
    begin
      result := NativeInt(@dy);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'scale') then
    begin
      result := NativeInt(@scale);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'delta') then
    begin
      result := NativeInt(@delta);
      DataType := dtDouble;
    end

  end
end;

function TSCHARR.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSCHARR.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                     TLAPLACIAN                  //////
/// /////////////////////////////////////////////////////////////////////////

function TLAPLACIAN.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'ksize') then
    begin
      result := NativeInt(@ksize);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'scale') then
    begin
      result := NativeInt(@scale);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'delta') then
    begin
      result := NativeInt(@delta);
      DataType := dtDouble;
    end

  end
end;

function TLAPLACIAN.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TLAPLACIAN.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                       TRESIZE                  //////
/// /////////////////////////////////////////////////////////////////////////
function TRESIZE.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'ksizeX') then
    begin
      result := NativeInt(@ksizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ksizeY') then
    begin
      result := NativeInt(@ksizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'interpolation') then
    begin
      result := NativeInt(@interpolation);
      DataType := dtInteger;
    end

  end
end;

function TRESIZE.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TRESIZE.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        res := sim_resize(src, @dst, ksizeX, ksizeY, interpolation);
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                               TCalibrateCamera                  //////
/// /////////////////////////////////////////////////////////////////////////
function TCalibrateCamera.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'numCornersHor') then
    begin
      result := NativeInt(@numCornersHor);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'numCornersVer') then
    begin
      result := NativeInt(@numCornersVer);
      DataType := dtInteger;
    end
    else if StrEqu(ParamName, 'fileName') then
    begin
      result := NativeInt(@fileName);
      DataType := dtString;
    end
  end
end;

function TCalibrateCamera.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TCalibrateCamera.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        image := pPointer(@U[0].Arr^[0])^;
        // ErrorEvent(IntToStr(numCornersHor), msError, VisualObject);
        // ErrorEvent(IntToStr(numCornersVer), msError, VisualObject);
        res := sim_fidnCalibrationPoints(@image_points, @object_points, image,
          @dstImage, numCornersHor, numCornersVer);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dstImage;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        res := sim_calibrateCamera(image_points, object_points, image,
          @intrinsic, @distCoeffs);
        if res = 0 then
        begin
          ErrorEvent('camera calibrated!!!', msInfo, VisualObject);
          sim_saveCalibrationParameters(fileName, intrinsic, distCoeffs);
          if res = 0 then
          begin
            ErrorEvent('calibration data saved to file: ' + fileName, msInfo,
              VisualObject);
          end;
        end;
        releaseSimMat(@dstImage);
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                 TUndistotImage                  //////
/// /////////////////////////////////////////////////////////////////////////
function TUndistotImage.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
  end
end;

function TUndistotImage.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TUndistotImage.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        src := pPointer(@U[0].Arr^[0])^;
        intrinsic := pPointer(@U[1].Arr^[0])^;
        distCoeffs := pPointer(@U[2].Arr^[0])^;
        res := sim_undistort(src, @dst, intrinsic, distCoeffs);
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                      TLoadCalibrationParameters                  //////
/// /////////////////////////////////////////////////////////////////////////
function TLoadCalibrationParameters.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'fileName') then
    begin
      result := NativeInt(@fileName);
      DataType := dtString;
    end
  end
end;

function TLoadCalibrationParameters.InfoFunc(Action: integer;
  aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TLoadCalibrationParameters.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        res := sim_loadCalibrationParameters(fileName, @intrinsic, @distCoeffs);
        if res = 0 then
        begin
          ErrorEvent('calibration data loaded from file: ' + fileName, msInfo,
            VisualObject);
          pPointer(@Y[0].Arr^[0])^ := intrinsic;
          pPointer(@Y[1].Arr^[0])^ := distCoeffs;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          pPointer(@Y[1].Arr^[0])^ := nil;
        end;
        result := 0;
      end;

    f_GoodStep:
      begin
        result := 0;
      end;

    f_Stop:
      begin
        result := 0;
      end;

  end
end;
/// /////////////////////////////////////////////////////////////////////////
/// //                               TwarpPerspective                  //////
/// /////////////////////////////////////////////////////////////////////////

function TwarpPerspective.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'dsizeX') then
    begin
      result := NativeInt(@dsizeX);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'dsizeY') then
    begin
      result := NativeInt(@dsizeY);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'srcX1') then
    begin
      result := NativeInt(@srcPts[1]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY1') then
    begin
      result := NativeInt(@srcPts[2]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcX2') then
    begin
      result := NativeInt(@srcPts[3]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY2') then
    begin
      result := NativeInt(@srcPts[4]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcX3') then
    begin
      result := NativeInt(@srcPts[5]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY3') then
    begin
      result := NativeInt(@srcPts[6]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcX4') then
    begin
      result := NativeInt(@srcPts[7]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'srcY4') then
    begin
      result := NativeInt(@srcPts[8]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX1') then
    begin
      result := NativeInt(@dstPts[1]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY1') then
    begin
      result := NativeInt(@dstPts[2]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX2') then
    begin
      result := NativeInt(@dstPts[3]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY2') then
    begin
      result := NativeInt(@dstPts[4]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX3') then
    begin
      result := NativeInt(@dstPts[5]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY3') then
    begin
      result := NativeInt(@dstPts[6]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstX4') then
    begin
      result := NativeInt(@dstPts[7]);
      DataType := dtDouble;
    end

    else

      if StrEqu(ParamName, 'dstY4') then
    begin
      result := NativeInt(@dstPts[8]);
      DataType := dtDouble;
    end

  end
end;

function TwarpPerspective.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TwarpPerspective.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of

    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                                    TFloodFill                  //////
/// /////////////////////////////////////////////////////////////////////////

function TFloodFill.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin

    if StrEqu(ParamName, 'px') then
    begin
      result := NativeInt(@px);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'py') then
    begin
      result := NativeInt(@py);
      DataType := dtInteger;
    end

    else

      if StrEqu(ParamName, 'ch1') then
    begin
      result := NativeInt(@ch1);
      DataType := dtInteger;
    end
    else

      if StrEqu(ParamName, 'ch2') then
    begin
      result := NativeInt(@ch2);
      DataType := dtInteger;
    end
    else

      if StrEqu(ParamName, 'ch3') then
    begin
      result := NativeInt(@ch3);
      DataType := dtInteger;
    end

  end
end;

function TFloodFill.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TFloodFill.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
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
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                            TFindContous                         //////
/// /////////////////////////////////////////////////////////////////////////

function TFindContous.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TFindContous.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        srcFrame := pPointer(@U[0].Arr^[0])^;
        res := sim_findContours(srcFrame, @contours);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := contours;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                            TSelectContour                         //////
/// /////////////////////////////////////////////////////////////////////////

function TSelectContour.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'index') then
    begin
      result := NativeInt(@index);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'width') then
    begin
      result := NativeInt(@width);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'red') then
    begin
      result := NativeInt(@red);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'green') then
    begin
      result := NativeInt(@green);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'blue') then
    begin
      result := NativeInt(@blue);
      DataType := dtInteger;
    end

  end
end;

function TSelectContour.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSelectContour.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        srcFrame := pPointer(@U[0].Arr^[0])^;
        contours := pPointer(@U[1].Arr^[0])^;

        res := sim_selectContour(srcFrame, contours, index, red, green, blue,
          width, @dstFrame, @contour);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := dstFrame;
          pPointer(@Y[1].Arr^[0])^ := contour;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          pPointer(@Y[1].Arr^[0])^ := nil;
        end;

        // pPointer(@Y[0].Arr^[0])^ := srcFrame;
        // pPointer(@Y[1].Arr^[0])^ := contours;
      end;

    f_Stop:
      begin
        result := 0;
      end;

  end
end;
/// /////////////////////////////////////////////////////////////////////////
/// //                         TSelectContourArea                      //////
/// /////////////////////////////////////////////////////////////////////////

function TSelectContourArea.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'minArea') then
    begin
      result := NativeInt(@minArea);
      DataType := dtDouble;
    end

    else if StrEqu(ParamName, 'maxArea') then
    begin
      result := NativeInt(@maxArea);
      DataType := dtDouble;
    end
  end
end;

function TSelectContourArea.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TSelectContourArea.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        inputContours := pPointer(@U[0].Arr^[0])^;
        res := sim_minMaxAreaContoursFilter(inputContours, @outputContours,
          @minArea, @maxArea);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := outputContours;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
        end;
      end;

    f_Stop:
      begin
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                         TFindSign                      //////
/// /////////////////////////////////////////////////////////////////////////
function TFindSign.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'normalizedContourSizeX') then
    begin
      result := NativeInt(@normalizedContourSizeX);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'normalizedContourSizeY') then
    begin
      result := NativeInt(@normalizedContourSizeY);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'useHull') then
    begin
      result := NativeInt(@useHull);
      DataType := dtBool;
    end

    else if StrEqu(ParamName, 'draw') then
    begin
      result := NativeInt(@draw);
      DataType := dtBool;
    end
    else if StrEqu(ParamName, 'minCorrelation') then
    begin
      result := NativeInt(@minCorrelation);
      DataType := dtDouble;
    end

  end
end;

function TFindSign.InfoFunc(Action: integer; aParameter: NativeInt): NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TFindSign.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        templFrame := pPointer(@U[0].Arr^[0])^;
        templContour := pPointer(@U[1].Arr^[0])^;
        frame := pPointer(@U[2].Arr^[0])^;
        contours := pPointer(@U[3].Arr^[0])^;
        res := sim_findSign(templFrame, templContour, frame, contours,
          normalizedContourSizeX, normalizedContourSizeY, useHull, draw,
          minCorrelation, @numFound);
        if res = 0 then
        begin
          Y[0].Arr^[0] := numFound;
          pPointer(@Y[1].Arr^[0])^ := frame;
        end
        else
        begin
          Y[0].Arr^[0] := 0;
          pPointer(@Y[1].Arr^[0])^ := nil;
        end;
        //ErrorEvent(IntToStr(numFound), msInfo, VisualObject);
      end;

    f_Stop:
      begin
        result := 0;
      end;

  end
end;

/// /////////////////////////////////////////////////////////////////////////
/// //                         TDetectLanes                      //////
/// /////////////////////////////////////////////////////////////////////////
function TDetectLanes.GetParamID;
begin
  result := inherited GetParamID(ParamName, DataType, IsConst);
  if result = -1 then
  begin
    if StrEqu(ParamName, 'numHorHist') then
    begin
      result := NativeInt(@numHorHist);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'wheel') then
    begin
      result := NativeInt(@wheel);
      DataType := dtInteger;
    end

    else if StrEqu(ParamName, 'roi') then
    begin
      result := NativeInt(@roi);
      DataType := dtInteger;
    end

  end
end;

function TDetectLanes.InfoFunc(Action: integer; aParameter: NativeInt)
  : NativeInt;
begin
  result := 0;
  case Action of
    i_GetCount:
      begin
        cY[0] := 1;
      end;
    i_GetInit:
      begin
        result := 1;
      end;
  else
    result := inherited InfoFunc(Action, aParameter);
  end
end;

function TDetectLanes.RunFunc;
var
  res: integer;
begin
  result := 0;
  case Action of
    f_InitState:
      begin
        result := 0;
      end;

    f_GoodStep:
      begin
        binaryinput := pPointer(@U[0].Arr^[0])^;
        drawinput := pPointer(@U[1].Arr^[0])^;
        res := sim_detectLanes(binaryinput, numHorHist, roi, wheel, @rd, @ld,
          drawinput);
        if res = 0 then
        begin
          pPointer(@Y[0].Arr^[0])^ := drawinput;
          Y[1].Arr^[0] := rd;
          Y[2].Arr^[0] := ld;
        end
        else
        begin
          pPointer(@Y[0].Arr^[0])^ := nil;
          rd := -1;
          ld := -1;
          Y[1].Arr^[0] := rd;
          Y[2].Arr^[0] := ld;
        end;
        ErrorEvent(IntToStr(rd) + ' <> ' + IntToStr(ld), msInfo, VisualObject);
      end;

    f_Stop:
      begin
        result := 0;
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
sim_flip := GetProcAddress(hDll, 'sim_flip');
sim_rotate := GetProcAddress(hDll, 'sim_rotate');
sim_split := GetProcAddress(hDll, 'sim_split');
sim_inRange := GetProcAddress(hDll, 'sim_inRange');
sim_merge := GetProcAddress(hDll, 'sim_merge');
sim_sobel := GetProcAddress(hDll, 'sim_sobel');
sim_scharr := GetProcAddress(hDll, 'sim_scharr');
sim_laplacian := GetProcAddress(hDll, 'sim_laplacian');
sim_resize := GetProcAddress(hDll, 'sim_resize');
sim_warpPerspective := GetProcAddress(hDll, 'sim_warpPerspective');
sim_floodFill := GetProcAddress(hDll, 'sim_floodFill');
sim_findContours := GetProcAddress(hDll, 'sim_findContours');
sim_selectContour := GetProcAddress(hDll, 'sim_selectContour');
sim_minMaxAreaContoursFilter := GetProcAddress(hDll,
  'sim_minMaxAreaContoursFilter');
sim_fidnCalibrationPoints := GetProcAddress(hDll, 'sim_fidnCalibrationPoints');
sim_undistort := GetProcAddress(hDll, 'sim_undistort');
sim_calibrateCamera := GetProcAddress(hDll, 'sim_calibrateCamera');
sim_saveCalibrationParameters := GetProcAddress(hDll,
  'sim_saveCalibrationParameters');
sim_loadCalibrationParameters := GetProcAddress(hDll,
  'sim_loadCalibrationParameters');
sim_findSign := GetProcAddress(hDll, 'sim_findSign');
sim_detectLanes := GetProcAddress(hDll, 'sim_detectLanes');

finalization

if hDll <> 0 then
  FreeLibrary(hDll);

end.
