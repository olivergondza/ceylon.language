(function(define) {
    define(function(require, exports, module) {

//the Ceylon language module
//#METAMODEL

function getT$name() {return this.constructor.T$name;}
function getT$all() {return this.constructor.T$all;}
function initType(type, typeName) {
    var cons = function() {}
    type.$$ = cons;
    cons.T$name = typeName;
    cons.T$all = {}
    cons.T$all[typeName] = type;
    for (var i=2; i<arguments.length; ++i) {
        var superTypes = arguments[i].$$.T$all;
        for (var $ in superTypes) {cons.T$all[$] = superTypes[$]}
    }
    cons.prototype.getT$name = getT$name;
    cons.prototype.getT$all = getT$all;
}
function initTypeProto(type, typeName) {
    initType.apply(this, arguments);
    var args = [].slice.call(arguments, 2);
    args.unshift(type);
    inheritProto.apply(this, args);
}
function initTypeProtoI(type, typeName) {
  initType.apply(this, arguments);
  var args = [].slice.call(arguments, 2);
  if (type.$$.T$all['ceylon.language::Object']===undefined) {
    type.$$.T$all['ceylon.language::Object']=Object$;
    //args.unshift(Object$);
  }
  args.unshift(type);
  inheritProto.apply(this, args);
}
function initExistingType(type, cons, typeName) {
    type.$$ = cons;
    cons.T$name = typeName;
    cons.T$all = {}
    cons.T$all[typeName] = type;
    for (var i=3; i<arguments.length; ++i) {
        var superTypes = arguments[i].$$.T$all;
        for (var $ in superTypes) {cons.T$all[$] = superTypes[$]}
    }
    var proto = cons.prototype;
    if (proto !== undefined) {
        try {
            proto.getT$name = getT$name;
            proto.getT$all = getT$all;
        } catch (exc) {
            // browser probably prevented access to the prototype
        }
    }
}
function initExistingTypeProto(type, cons, typeName) {
    var args = [].slice.call(arguments, 0);
    args.push($init$Basic());
    initExistingType.apply(this, args);
    var proto = cons.prototype;
    if ((proto !== undefined) && (proto.getHash === undefined)) {
    	var origToString = proto.toString;
        try {
            inheritProto(type, Basic);
            proto.toString = origToString;
        } catch (exc) {
            // browser probably prevented access to the prototype
        }
    }
}
function inheritProto(type) {
    var proto = type.$$.prototype;
    for (var i=1; i<arguments.length; ++i) {
        var superProto = arguments[i].$$.prototype;
        var names = Object.getOwnPropertyNames(superProto);
        for (var j=0; j<names.length; ++j) {
            var name = names[j];
            var desc = Object.getOwnPropertyDescriptor(superProto, name);
            // only copy own, enumerable properties
            if (desc && desc.enumerable) {
                if (desc.get) {
                    // defined through getter/setter, so copy the definition
                    Object.defineProperty(proto, name, desc);
                } else if (proto[name]===undefined || desc.value.$fml===undefined) {
                    proto[name] = desc.value;
                }
            }
        }
    }
}
// Define a property on the given object (which may be a prototype).
// "get" and "set" are getter/setter functions, and the latter is optional.
function defineAttr(obj, name, get, set, metamodel,setterAnns) {
  Object.defineProperty(obj, name, {get: get, set: set, configurable: true, enumerable: true});
  if (name[0]==='$')name=name.substring(1);//names matching reserved words are prefixed with $
  obj['$prop$get'+name[0].toUpperCase()+name.substring(1)] = {get:get, set:set, $$metamodel$$:metamodel};
  if (setterAnns)set.setter$anns=setterAnns;
}
// Create a copy of the given property. The name of the copied property is name+suffix.
// This is used in closure mode to provide access to inherited attribute implementations.
function copySuperAttr(obj, name, suffix) {
    var desc;
    var o = obj;
    // It may be an inherited property, so check the prototype chain.
    do {
        if ((desc = Object.getOwnPropertyDescriptor(o, name))) {break;}
        o = o.__proto__;
    } while (o);
    if (desc) {
        Object.defineProperty(obj, name+suffix, desc);
    }
}
// read/writeAttrib return the getter/setter for the given property as defined in the
// given type. This is used in prototype mode to access inherited attribute implementations.
function attrGetter(type, name) {
    return Object.getOwnPropertyDescriptor(type.$$.prototype, name).get;
}
function attrSetter(type, name, value) {
    return Object.getOwnPropertyDescriptor(type.$$.prototype, name).set;
}
exports.initType=initType;
exports.initTypeProto=initTypeProto;
exports.initTypeProtoI=initTypeProtoI;
exports.initExistingType=initExistingType;
exports.initExistingTypeProto=initExistingTypeProto;
exports.inheritProto=inheritProto;
exports.defineAttr=defineAttr;
exports.copySuperAttr=copySuperAttr;
exports.attrGetter=attrGetter;
exports.attrSetter=attrSetter;

function Anything(wat) {
    return wat;
}
initType(Anything, 'ceylon.language::Anything');
Anything.$$metamodel$$=function(){return{$an:function(){return[shared(),abstract()]},mod:$$METAMODEL$$,d:['ceylon.language','Anything']};}
function Null(wat) {
    return null;
}
initType(Null, 'ceylon.language::Null', Anything);
Null.$$metamodel$$=function(){return{'super':{t:Anything},$an:function(){return[shared(),abstract()]},mod:$$METAMODEL$$,d:['ceylon.language','Null']};}
function Nothing(wat) {
    throw "Nothing";
}
initType(Nothing, 'ceylon.language::Nothing');
//This is quite a special case, since Nothing is not in the model, we need to insert it there
$$METAMODEL$$['ceylon.language']["Nothing"]={"$mt":"cls","$an":{"shared":[]},"$nm":"Nothing"};
Nothing.$$metamodel$$=function(){return{$ps:[],$an:function(){return[shared()]},mod:$$METAMODEL$$,d:['ceylon.language','Nothing']};}

function Object$(wat) {
    return wat;
}
initTypeProto(Object$, 'ceylon.language::Object', Anything);
Object$.$$metamodel$$=function(){return{'super':{t:Anything},$an:function(){return[shared(),abstract()]},mod:$$METAMODEL$$,d:['ceylon.language','Object']};}
var Object$proto = Object$.$$.prototype;
defineAttr(Object$proto, 'string', function(){
    return String$(className(this) + "@" + this.hash);
},undefined,{$an:function(){return[shared(),$default()]},$t:{t:String$},mod:$$METAMODEL$$,$cont:Object$,d:['ceylon.language','Object','$at','string']});
Object$proto.$prop$getHash={$fml:1,$$metamodel$$:function(){return{mod:$$METAMODEL$$,$cont:Object$,d:['ceylon.language','Object','$at','hash'],$t:{t:Integer}};}};
Object$proto.toString=function() { return this.string.valueOf(); }
Object$proto.equals={$fml:1,$$metamodel$$:function(){return{mod:$$METAMODEL$$,$cont:Object$,d:['ceylon.language','Object','$m','equals'],$t:{t:Boolean$},
  $ps:[{$nm:'other',$mt:'prm',$t:{t:Object$}}]};}};
function $init$Object$() { return Object$; }
function $init$Object() { return Object$; }
function $init$$Object() { return Object$; }

var $Object=Object$;

var BasicID=1;
function $identityHash(x) {
    var hash = x.BasicID;
    return (hash !== undefined)
            ? hash : (x.BasicID = BasicID++);
}
$identityHash.$$metamodel$$=function(){return{mod:$$METAMODEL$$,$t:{t:Integer},$ps:[{$nm:'x',$t:{t:Identifiable},$mt:'prm'}],d:['ceylon.language','identityHash']};}
function Identifiable(obj) {}
initType(Identifiable, "ceylon.language::Identifiable", Object$);
Identifiable.$$metamodel$$=function(){return{$an:function(){return[shared()]},mod:$$METAMODEL$$,d:['ceylon.language','Identifiable']};}
function $init$Identifiable() { return Identifiable; }
var Identifiable$proto = Identifiable.$$.prototype;
Identifiable$proto.equals = function(that) {
    return isOfType(that, {t:Identifiable}) && (that===this);
}
defineAttr(Identifiable$proto, 'hash', function(){ return $identityHash(this); },
    undefined,function(){return{$an:function(){return[shared(),$default()]},$cont:Identifiable,mod:$$METAMODEL$$,d:['ceylon.language','Identifiable','$at','hash']};});

//INTERFACES
//Compiled from Ceylon sources
//#COMPILED
//Ends compiled from Ceylon sources

function NativeException(e) {
    var that = new NativeException.$$;
    var msg;
    if (typeof e === 'string') {
        msg = String$(e);
    } else if (e) {
        msg = String$(e.toString());
    } else {
        msg = String$("Native JavaScript Exception",27);
    }
    Exception(msg,null,that);
    return that;
}
initTypeProto(NativeException, 'ceylon.language::NativeException', $init$Exception());
NativeException.$$metamodel$$=function(){return{$nm:'NativeException',$mt:'cls',$ps:[{t:Exception}],$an:function(){return[shared()];},mod:$$METAMODEL$$,d:['ceylon.language','Exception']};}
exports.Identifiable=Identifiable;
exports.identityHash=$identityHash;
exports.$Object=Object$;
exports.Anything=Anything;
exports.Null=Null;
exports.Nothing=Nothing;
exports.$Boolean=Boolean$;
exports.Comparison=Comparison;
exports.getNull=getNull;
exports.getTrue=getTrue;
exports.getFalse=getFalse;
exports.NativeException=NativeException;
    });
}(typeof define==='function' && define.amd ? 
    define : function (factory) {
    if (typeof exports!=='undefined') {
        factory(require, exports, module);
    } else {
        throw "no module loader";
    }
}));
