function testInvalidFunctionCallWithNull() returns (any) {
    string? s = ();
    return foo(s);
}

function foo(string? s) returns (string?){
    return s;
}

//function testLogicalOperationOnNull1() returns (boolean) {
//    xml? x = ();
//    return (() > x);
//}

//function testNullForValueType1() {
//    int a = ();
//}

function testArithmaticOperationOnNull() returns (any) {
    return null;
}

type Person record {| string name; |};
function testNullNegativeScenarios() {
    map<Person>? a = null;
    Person? b = null;
    Person[]? c= null;
    Person?[] d = [null , {"name": "John"}];
}

//function testNullForValueType2() {
//    string s = ();
//}
//
//function testNullForValueType3() {
//    json j = null;
//}
//
//function testArithmaticOperationOnNull2() returns (any) {
//    return (() + ());
//}