part of '../runtime.dart';

class PushConstant implements DbcOp {
  PushConstant(Runtime runtime) :
        _const = runtime._readInt32();

  PushConstant.make(this._const);

  final int _const;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I32_LEN;

  // Set value at position to constant
  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = runtime.constantPool[_const];
  }

  @override
  String toString() => 'PushConstant (C$_const)';
}

class PushConstantInt implements DbcOp {
  PushConstantInt(Runtime exec) : _value = exec._readInt32();

  PushConstantInt.make(this._value);

  final int _value;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I32_LEN;

  // Set value at position to constant
  @override
  void run(Runtime exec) {
    exec.frame[exec.frameOffset++] = _value;
  }

  @override
  String toString() => 'PushConstantInt ($_value)';
}

class PushNull implements DbcOp {
  PushNull(Runtime exec);

  PushNull.make();

  static const int LEN = Dbc.BASE_OPLEN;

  // Set value at position to constant
  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = null;
  }

  @override
  String toString() => 'PushNull ()';
}

class NumAdd implements DbcOp {
  NumAdd(Runtime runtime) :
        _location1 = runtime._readInt16(),
        _location2 = runtime._readInt16();

  NumAdd.make(this._location1, this._location2);

  final int _location1;
  final int _location2;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN * 2;

  // Add value A + B
  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = (runtime.frame[_location1] as num) + (runtime.frame[_location2] as num);
  }

  @override
  String toString() => 'NumAdd (L$_location1 + L$_location2)';
}

class NumSub implements DbcOp {
  NumSub(Runtime runtime) :
        _location1 = runtime._readInt16(),
        _location2 = runtime._readInt16();

  NumSub.make(this._location1, this._location2);

  final int _location1;
  final int _location2;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN * 2;

  // Add value A + B
  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = (runtime.frame[_location1] as num) - (runtime.frame[_location2] as num);
  }

  @override
  String toString() => 'NumSub (L$_location1 - L$_location2)';
}

class NumLt implements DbcOp {
  NumLt(Runtime runtime)
      : _location1 = runtime._readInt16(),
        _location2 = runtime._readInt16();

  NumLt.make(this._location1, this._location2);

  final int _location1;
  final int _location2;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN * 2;

  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = (runtime.frame[_location1] as num) < (runtime.frame[_location2] as num);
  }

  @override
  String toString() => 'NumLt (L$_location1 < L$_location2)';
}

class NumLtEq implements DbcOp {
  NumLtEq(Runtime runtime)
      : _location1 = runtime._readInt16(),
        _location2 = runtime._readInt16();

  NumLtEq.make(this._location1, this._location2);

  final int _location1;
  final int _location2;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN * 2;

  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = (runtime.frame[_location1] as num) <= (runtime.frame[_location2] as num);
  }

  @override
  String toString() => 'NumLtEq (L$_location1 <= L$_location2)';
}

class BoxInt implements DbcOp {
  BoxInt(Runtime runtime) : _reg = runtime._readInt16();

  BoxInt.make(this._reg);

  final int _reg;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN;

  @override
  void run(Runtime runtime) {
    final reg = _reg;
    runtime.frame[reg] = $int(runtime.frame[reg] as int);
  }

  @override
  String toString() => 'BoxInt (L$_reg)';
}

class BoxDouble implements DbcOp {
  BoxDouble(Runtime runtime) : _reg = runtime._readInt16();

  BoxDouble.make(this._reg);

  final int _reg;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN;

  @override
  void run(Runtime runtime) {
    final reg = _reg;
    runtime.frame[reg] = $double(runtime.frame[reg] as double);
  }

  @override
  String toString() => 'BoxDouble (L$_reg)';
}

class BoxNum implements DbcOp {
  BoxNum(Runtime runtime) : _reg = runtime._readInt16();

  BoxNum.make(this._reg);

  final int _reg;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN;

  @override
  void run(Runtime runtime) {
    final reg = _reg;
    runtime.frame[reg] = $num(runtime.frame[reg] as num);
  }

  @override
  String toString() => 'BoxNum (L$_reg)';
}

class BoxString implements DbcOp {
  BoxString(Runtime runtime) : _reg = runtime._readInt16();

  BoxString.make(this._reg);

  final int _reg;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN;

  @override
  void run(Runtime runtime) {
    final reg = _reg;
    runtime.frame[reg] = $String(runtime.frame[reg] as String);
  }

  @override
  String toString() => 'BoxString (L$_reg)';
}

class BoxList implements DbcOp {
  BoxList(Runtime runtime) : _reg = runtime._readInt16();

  BoxList.make(this._reg);

  final int _reg;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN;

  @override
  void run(Runtime runtime) {
    final reg = _reg;
    runtime.frame[reg] = $List.wrap(<$Value>[...(runtime.frame[reg] as List)]);
  }

  @override
  String toString() => 'BoxList (L$_reg)';
}

class Unbox implements DbcOp {
  Unbox(Runtime runtime) : _reg = runtime._readInt16();

  Unbox.make(this._reg);

  final int _reg;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN;

  @override
  void run(Runtime runtime) {
    runtime.frame[_reg] = (runtime.frame[_reg] as $Value).$value;
  }

  @override
  String toString() => 'Unbox (L$_reg)';
}

class PushList extends DbcOp {
  PushList(Runtime runtime);

  PushList.make();

  static const int LEN = Dbc.BASE_OPLEN;

  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = [];
  }

  @override
  String toString() => 'PushList ()';
}

class ListAppend extends DbcOp {
  ListAppend(Runtime runtime)
      : _reg = runtime._readInt16(),
        _value = runtime._readInt16();

  ListAppend.make(this._reg, this._value);

  final int _reg;
  final int _value;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN * 2;

  @override
  void run(Runtime runtime) {
    (runtime.frame[_reg] as List).add(runtime.frame[_value]);
  }

  @override
  String toString() => 'ListAppend (L$_reg[] = L$_value)';
}

class IndexList extends DbcOp {
  IndexList(Runtime runtime) :
        _position = runtime._readInt16(),
        _index = runtime._readInt32();

  IndexList.make(this._position, this._index);

  final int _position;
  final int _index;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN + Dbc.I32_LEN;

  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = (runtime.frame[_position] as List)[runtime.frame[_index] as int];
  }

  @override
  String toString() => 'IndexList (L$_position[L$_index])';
}

class ListSetIndexed extends DbcOp {
  ListSetIndexed(Runtime runtime)
      : _position = runtime._readInt16(),
        _index = runtime._readInt32(),
        _value = runtime._readInt16();

  ListSetIndexed.make(this._position, this._index, this._value);

  final int _position;
  final int _index;
  final int _value;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN * 2 + Dbc.I32_LEN;

  @override
  void run(Runtime runtime) {
    final frame = runtime.frame;
    (frame[_position] as List)[frame[_index] as int] = frame[_value];
  }

  @override
  String toString() => 'ListSetIndexed (L$_position[L$_index] = L$_value)';
}

class PushIterableLength extends DbcOp {
  PushIterableLength(Runtime runtime) : _position = runtime._readInt16();

  PushIterableLength.make(this._position);

  final int _position;

  static const int LEN = Dbc.BASE_OPLEN + Dbc.I16_LEN + Dbc.I32_LEN;

  @override
  void run(Runtime runtime) {
    runtime.frame[runtime.frameOffset++] = (runtime.frame[_position] as Iterable).length;
  }

  @override
  String toString() => 'PushIterableLength (L$_position)';
}
