// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

type Employee record {
    string name;
    Employee? employer = ();
    int id;
};

type Person record {
    string name;
    Person? employer = ();
};

function testRecordFieldAccess1() returns boolean {
    string s = "Anne";
    Employee e = { name: s, id: 100 };
    return s == e.name;
}

function testRecordFieldAccess2() returns boolean {
    string s = "Anne";
    Employee e = { name: s, id: 1001 };
    Employee|Person ep = e;
    string name = ep.name;
    Employee|Person? employer = ep.employer;
    return s == name && employer == ();
}

type EmployeeTwo record {
    string name;
    int id;
};

type PersonTwo record {
    string name;
    string id;
    float salary;
};

function testRecordFieldAccess3() returns boolean {
    string s1 = "John";
    string s2 = "ASD123";
    PersonTwo e = { name: s1, id: s2, salary: 100.0 };
    EmployeeTwo|PersonTwo ep = e;
    string name = ep.name;
    string|int id = ep.id;
    return name == s1 && id == s2;
}

int i = 12;
json j1 = { a: { b: i } };
map<json> j2 = { a: { b: i } };

function testJsonFieldAccessPositive() returns boolean[2] {
    return [testJsonFieldAccessPositive1(j1), testJsonFieldAccessPositive2(j1)];
}

function testJsonFieldAccessNegative() returns boolean[5] {
    return [testNonMappingJsonFieldAccessNegative1(j1), testNonMappingJsonFieldAccessNegative2(j1),
            testJsonFieldAccessNegativeMissingKey1(j1), testJsonFieldAccessNegativeMissingKey2(j1),
            testJsonFieldAccessNegativeMissingKey3(j1)];
}

function testMapJsonFieldAccessPositive() returns boolean[2] {
    return [testJsonFieldAccessPositive1(j2), testJsonFieldAccessPositive2(j2)];
}

function testMapJsonFieldAccessNegative() returns boolean[5] {
    return [testNonMappingJsonFieldAccessNegative1(j2), testNonMappingJsonFieldAccessNegative2(j2),
            testJsonFieldAccessNegativeMissingKey1(j2), testJsonFieldAccessNegativeMissingKey2(j2),
            testJsonFieldAccessNegativeMissingKey3(j2)];
}

function testJsonFieldAccessPositive1(json j) returns boolean {
    json be = { b: i };
    json|error a = j.a;
    return a is json && a == be;
}

function testJsonFieldAccessPositive2(json j) returns boolean {
    json|error b = j.a.b;
    return b is json && b == i;
}

function testNonMappingJsonFieldAccessNegative1(json j) returns boolean {
    json|error a = j.a.b.c;

    if (a is error) {
        map<anydata|error> detailMap = a.detail();
        return a.reason() == "{ballerina}JSONOperationError" && detailMap["message"] == "JSON value is not a mapping";
    }
    return false;
}

function testNonMappingJsonFieldAccessNegative2(json j) returns boolean {
    json|error a = j.a.b.c.d;

    if (a is error) {
        map<anydata|error> detailMap = a.detail();
        return a.reason() == "{ballerina}JSONOperationError" && detailMap["message"] == "JSON value is not a mapping";
    }
    return false;
}

function testJsonFieldAccessNegativeMissingKey1(json j) returns boolean {
    json|error a = j.a.d;

    if (a is error) {
        map<anydata|error> detailMap = a.detail();
        return a.reason() == "{ballerina}KeyNotFound" && detailMap["message"] == "Key 'd' not found in JSON mapping";
    }
    return false;
}

function testJsonFieldAccessNegativeMissingKey2(json j) returns boolean {
    json|error a = j.e;

    if (a is error) {
        map<anydata|error> detailMap = a.detail();
        return a.reason() == "{ballerina}KeyNotFound" && detailMap["message"] == "Key 'e' not found in JSON mapping";
    }
    return false;
}

function testJsonFieldAccessNegativeMissingKey3(json j) returns boolean {
    json|error a = j.e.f;

    if (a is error) {
        map<anydata|error> detailMap = a.detail();
        return a.reason() == "{ballerina}KeyNotFound" && detailMap["message"] == "Key 'e' not found in JSON mapping";
    }
    return false;
}
