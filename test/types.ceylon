interface MyIdentifiable satisfies Identifiable {}
class MyIdentifiableObject() {}

class T() extends Object() {
    shared actual String string = "hello";
    shared actual Boolean equals(Object that) {
        return that.string==string;
    }
    shared actual Integer hash {
        return string.hash;
    }
}

interface Format {}

class TypesPair<out X,out Y>(X x, Y y) 
        given X satisfies Object
        given Y satisfies Object {
    shared actual default String string {
        return "(" x.string ", " y.string ")";
    }
}

class TypesComplex(Float x, Float y) 
        extends TypesPair<Float, Float>(x,y) {
    shared actual String string {
        return "" x.string "+" y.string "i"; 
    }
    shared String pairString {
        return super.string;
    }
}

interface TypesList<out X> {
    shared formal Integer size;
    shared formal Boolean empty;
}

class ConcreteTypesList<out X>(X... xs) 
        satisfies TypesList<X> {
    shared actual Integer size {
        return 0;
    }
    shared actual Boolean empty {
        return true;
    }
}

class TypesCouple<X>(x, y) 
        extends TypesPair<X,X>(x,y) 
        given X satisfies Object {
    shared X x;
    shared X y;
}


class JsIssue9C1() {
    shared default String test() { return "1"; }
}
class JsIssue9C2() extends JsIssue9C1() {
    variable Boolean flag1 := false;
    shared actual default String test() {
        if (flag1) {
            return "ERR1";
        }
        flag1 := true;
        return super.test() + "2";
    }
}
class JsIssue9C3() extends JsIssue9C2() {
    variable Boolean flag2 := false;
    shared actual default String test() {
        if (flag2) {
            return "ERR2";
        }
        flag2 := true;
        return super.test() + "3";
    }
}

void testJsIssue9() {
    value obj = JsIssue9C3();
    check(obj.test()=="123", "Issue #9");
}

//originally in ceylon-js
interface TypeTestI1 {}
interface TypeTestI2 {}
interface TypeTestI3 {}
interface TypeTestI4 {}

class TypeTestC1() satisfies TypeTestI1&TypeTestI2{}
class TypeTestC3() satisfies TypeTestI3{}


void types() {
    Void bool = true;
    Void entry = 1->2;
    Void nothing = null;
    Void one = 1;
    Void t = T();
    Void c = `c`;
    Void str = "string";
    Void seq = {"hello"};
    Void empty = {};
    
    check(is Object bool, "boolean type is object");
    check(is IdentifiableObject bool, "boolean type is identifiable");
    //check(is Equality bool, "boolean type is equality");
    check(!is Nothing bool, "not null boolean type is not nothing");
    check(is Boolean bool, "boolean type 1");
    //check(is Void bool, "boolean type 2");
    //check(is Nothing|Boolean bool, "boolean type 3");
    
    check(is Nothing nothing, "null type 1");
    //check(!is Equality nothing, "null type 2");
    check(!is Object nothing, "null type 3");
    check(!is IdentifiableObject nothing, "null type 4");
    //check(is Void nothing, "null type 5");
        
    check(is Object entry, "entry type 1");
    check(!is IdentifiableObject entry, "not entry type");
    //check(is Equality entry, "entry type 2");
    check(!is Nothing entry, "not null entry type");
    check(is Entry<Object,Object> entry, "entry type 3");
    //check(is Entry<Integer,Integer> entry, "entry type 3");
    //check(is Void entry, "entry type 4");
        
    check(is Object one, "not natural type 1");
    check(!is IdentifiableObject one, "not natural type 2");
    //check(is Equality one, "natural type 1");
    check(!is Nothing one, "not null natural type");
    check(is Integer one, "natural type 2");
    //check(is Void nothing, "natural type 3");
        
    check(is Object c, "not char type 1");
    check(!is IdentifiableObject c, "not char type 1");
    //check(is Equality c, "char type 1");
    check(!is Nothing c, "not null char type");
    check(is Character c, "char type 2");
    //check(is Void c, "char type 3");
        
    check(is Object str, "not string type 1");
    check(!is IdentifiableObject str, "not string type 1");
    //check(is Equality str, "string type 1");
    check(!is Nothing str, "not null string type");
    check(is String str, "string type 2");
    //check(is Void str, "string type 3");
            
    //check(!is Equality t, "not eq custom type");
    check(!is IdentifiableObject t, "not id custom type");
    check(!is Nothing t, "custom type 1");
    check(is Object t, "custom type 2");
    check(is T t, "custom type 3");
    //check(is Void t, "custom type 4");
                
    //if (is Equality bool) {} else { fail("boolean type 4"); }
    if (is IdentifiableObject bool) {} else { fail("boolean type 5"); }
    if (is Object bool) {} else { fail("boolean type 6"); }
    if (is Nothing bool) { fail("null type 6"); }
    if (is Boolean? bool) {} else { fail("optional boolean type 7"); }

    //if (is Equality one) {} else { fail("natural type 4"); }
    if (is IdentifiableObject one) { fail("natural type 5"); }
    if (is Object one) {} else { fail("natural type 6"); }
    if (is Nothing one) { fail("null type 7"); }
    if (is Integer one) {} else { fail("natural type 7"); }
    if (is Integer? one) {} else { fail("optional natural type 8"); }

    //if (is Equality c) {} else { fail("character type 1"); }
    if (is IdentifiableObject c) { fail("character type 2"); }
    if (is Object c) {} else { fail("character type 3"); }
    if (is Nothing c) { fail("null type 8"); }
    if (is Character c) {} else { fail("character type 4"); }
    if (is Character? c) {} else { fail("optional character type 5"); }

    //if (is Equality str) {} else { fail("string type 4"); }
    if (is IdentifiableObject str) { fail("string type 5"); }
    if (is Object str) {} else { fail("string type 6"); }
    if (is Nothing str) { fail("null type 9"); }
    if (is String? str) {} else { fail("optional string type 7"); }

    //if (is Equality t) { fail("custom type 5"); }
    if (is IdentifiableObject t) { fail("custom type 6"); }
    if (is Object t) {} else { fail("custom type 7"); }
    if (is Nothing t) { fail("null type 10"); }
    if (is T? t) {} else { fail("optional custom type 8"); }

    //if (is Equality entry) {} else { fail("entry type 5"); }
    if (is IdentifiableObject entry) { fail("entry type 6"); }
    if (is Object entry) {} else { fail("entry type 7"); }
    if (is Nothing entry) { fail("null type 11"); }
    if (is Entry<Object,Object> entry) {} else { fail("entry type 8"); }
    //if (is Entry<Integer,Integer> entry) {} else { fail("entry type 8"); }
    //if (is Entry<Integer,String> entry) { fail("entry type 9 (required reified gens)"); }
    
    //if (is Equality nothing) { fail("null type 12"); }
    if (is IdentifiableObject nothing) { fail("null type 13"); }
    if (is Object nothing) { fail("null type 14"); }
    if (is Nothing nothing) {} else { fail("null type 15"); }
    if (is Character? nothing) {} else { fail("null is optional type"); }
    
    if (is Boolean|Character|T bool) {} else { fail("union type 1"); }
    if (is Boolean|Character|T t) {} else { fail("union type 2"); }
    if (is Boolean|Character|T str) { fail("union type 3"); } else {}
    if (is Boolean|Character|T nothing) { fail("union type 4"); } else {}
    if (is Object&Castable<Bottom> one) {} else { fail("intersection type 1"); }
    if (is Object&Castable<Bottom> bool) { fail("intersection type 2"); } else {}
    if (is Sized&Category&Iterable<Void> str) {} else { fail("intersection type 3"); }
    if (is Sized&Category&Iterable<Void> t) { fail("intersection type 4"); } else {}
    //if (is String[] empty) {} else { fail("sequence type 1"); }
    //if (is String[] seq) {} else { fail("sequence type 2"); }
    //if (is String[]? seq) {} else { fail("sequence type 3"); }
    //if (is Integer[] seq) { fail("sequence type 4 (required reified gens)"); } else {}
    
    check(className(1)=="ceylon.language::Integer", "natural classname");
    check(className(1.0)=="ceylon.language::Float", "float classname");
    check(className("hello").endsWith(".language::StringOfSome"), "string classname [1] " + className("hello"));
    check(className("").endsWith(".language::StringOfNone"), "string classname [2] " + className(""));
    check(className(` `)=="ceylon.language::Character", "character classname");
    check(className(1->"hello")=="ceylon.language::Entry", "entry classname");
    check(className(true)=="ceylon.language::true", "true classname");
    check(className(false)=="ceylon.language::false", "false classname");

    //from ceylon-js
    value pair = TypesPair("hello", "world");
    check(pair.string=="(hello, world)", "pair.string");
    Object pairObj = pair;
    check(is TypesPair<Object, Object> pairObj, "pair type");
    //check(is TypesPair<String, String> pairObj, "pair type");
    value almostZero = TypesComplex(0.1, 0.1);
    check(almostZero.string=="0.1+0.1i", "complex.string: expected '0.1+0.1i' got " almostZero.string "");
    check(almostZero.pairString=="(0.1, 0.1)", "complex.pairString: expected (0.1, 0.1) got " almostZero.pairString "");
    check(ConcreteTypesList().empty, "concreteList.empty");
    testJsIssue9();

    TypeTestC1|TypeTestC3 c1 = TypeTestC1();
    if (is TypeTestI1&TypeTestI2|TypeTestI3&TypeTestI4 c1) {} else { fail("is A&B|C&D"); }
    
    object myId extends Object() satisfies MyIdentifiable {}
    object myIdo extends MyIdentifiableObject() {}
    Object yourId = myId;
    Object yourIdo = myIdo;
    Object ido = MyIdentifiableObject();
    check(yourId is Identifiable, "is identifiable");
    check(!yourId is IdentifiableObject, "is not identifiable object");
    check(yourIdo is Identifiable, "is identifiable 1");
    check(yourIdo is IdentifiableObject, "is identifiable object 1");
    check(ido is Identifiable, "is identifiable 2");
    check(ido is IdentifiableObject, "is identifiable object 2");
}
