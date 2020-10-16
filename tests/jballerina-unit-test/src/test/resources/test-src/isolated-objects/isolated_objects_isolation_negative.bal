// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

isolated class InvalidIsolatedClassWithNonPrivateMutableFields {
    int a;
    public map<int> b;
    private final string c = "invalid";

    function init(int a, map<int> b) {
        self.a = a;
        self.b = b.clone();
    }
}

isolated object {} invalidIsolatedObjectConstructorWithNonPrivateMutableFields = object {
    int a;
    public map<int> b;
    private final string c = "invalid";

    function init() {
        self.a = 1;
        self.b = {};
    }
};

type IsolatedObjectType isolated object {
    int a;
    string[] b;
};

isolated class InvalidIsolatedClassNotOverridingMutableFieldsInIncludedIsolatedObject {
    *IsolatedObjectType;

    function init() {
        self.a = 1;
        self.b = [];
    }
}

isolated class InvalidIsolatedClassAccessingMutableFieldsOutsideLock {
    final int a = 1;
    private string b = "hello";
    private int[] c;

    function init(int[] c) {
        self.c = c.clone();
    }

    function getB() returns string => self.b;

    function setB(string s) {
        self.b = s;
    }

    function updateAndGetC(int i) returns int[] {
        lock {
            self.c.push(i); // OK
        }
        return self.c;
    }
}

function testInvalidIsolatedObjectConstructorAccessingMutableFieldsOutsideLock() {
    isolated object {} invalidIsolatedObjectConstructorAccessingMutableFieldsOutsideLock = object {
        final int a = 1;
        private string b = "hello";
        private int[] c = [];

        function getB() returns string => self.b;

        function setB(string s) {
            self.b = s;
        }

        function updateAndGetC(int i) returns int[] {
            lock {
                self.c.push(i); // OK
            }
            return self.c;
        }
    };
}

int[] globIntArr = [1200, 12, 12345];
int[] globIntArrCopy = globIntArr;
int[] globIntArrCopy2 = globIntArrCopy;

map<boolean> globBoolMap = {a: true, b: false};

function accessGlobBool() {
    _ = globBoolMap;
}

isolated class InvalidIsolatedClassWithNonUniqueInitializerExprs {
    private int[][] a;
    private map<boolean> b = globBoolMap;
    private record {} c;
    final string d = "str";

    function init(int[][]? a) {
        if a is int[][] {
            self.a = a;
        } else {
            self.a = [globIntArr, globIntArr];
        }

        record {} rec = {"a": 1, "b": 2.0};
        anydata ad = rec;
        self.c = rec;
    }
}

function testInvalidIsolatedObjectWithNonUniqueInitializerExprs() {
    isolated object {} invalidIsolatedObjectWithNonUniqueInitializerExprs = object {
        private int[][] a = [globIntArr, globIntArr];
        private map<boolean> b = globBoolMap;
        private record {} c;
        final string d = "str";

        function init() {
            record {} rec = {"a": 1, "b": 2.0};
            anydata ad = rec;
            self.c = rec;
        }
    };
}

isolated class InvalidIsolatedClassWithInvalidCopyIn {
    public final record {} & readonly a;
    private int b;
    private map<boolean>[] c;

    function init(record {} & readonly a, int b, map<boolean>[] c) {
        self.a = a;
        self.b = b;
        self.c = c.clone();
    }

    function invalidCopyInOne(map<boolean> boolMap) {
        map<boolean> bm1 = {};
        lock {
            map<boolean> bm2 = {a: true, b: false};

            self.c[0] = globBoolMap;
            self.c.push(boolMap);
            self.c = [bm1, bm2];
        }
    }

    isolated function invalidCopyInTwo(map<boolean> boolMap) {
        map<boolean> bm1 = {};
        lock {
            map<boolean> bm2 = {};
            lock {
                map<boolean> bm3 = boolMap;
                bm2 = bm3;
            }

            self.c.push(boolMap);
            self.c[0] = boolMap;
            self.c = [bm1, bm2];
        }
    }
}

isolated object {} invalidIsolatedObjectWithInvalidCopyIn = object {
    public final record {} & readonly a = {"type": "final"};
    private int b = 0;
    private map<boolean>[] c = [];

    isolated function invalidCopyInOne(map<boolean> boolMap) {
        map<boolean> bm1 = {};
        lock {
            map<boolean> bm2 = {a: true, b: false};

            self.c[0] = boolMap;
            self.c.push(boolMap);
            self.c = [bm1, bm2];
        }
    }

    function invalidCopyInTwo(map<boolean> boolMap) {
        map<boolean> bm1 = {};
        lock {
            map<boolean> bm2 = {};
            lock {
                map<boolean> bm3 = boolMap;
                bm2 = bm3;
            }

            self.c.push(boolMap);
            self.c[0] = globBoolMap;
            self.c = [bm1, bm2];
        }
    }
};

isolated class InvalidIsolatedClassWithInvalidCopyOut {
    public final record {} & readonly a = {"type": "final"};
    private int b = 1;
    private map<boolean>[] c;

    function init() {
        self.c = [];
    }

    function invalidCopyOutOne(map<boolean>[] boolMaps) {
        map<boolean>[] bm1 = boolMaps;
        lock {
            map<boolean>[] bm2 = [{a: true, b: false}];

            bm1 = self.c;
            globBoolMap = bm2[0];
            bm1 = [self.c[0]];
        }
    }

    isolated function invalidCopyOutTwo(map<boolean>[] boolMaps) {
        map<boolean> bm1 = {};
        lock {
            map<boolean> bm2 = {};
            lock {
                map<boolean> bm3 = boolMaps[0].clone();
                bm1 = bm3;
            }

            bm1 = self.c[0];
            bm1 = bm2;
        }
    }
}

function testInvalidIsolatedObjectWithInvalidCopyIn() {
    isolated object {} invalidIsolatedObjectWithInvalidCopyIn = object {
        private map<boolean>[] c = [];

        isolated function invalidCopyOutOne(map<boolean>[] boolMaps) {
            map<boolean>[] bm1 = boolMaps;
            lock {
                map<boolean>[] bm2 = [{a: true, b: false}];

                bm1 = self.c;
                bm1 = bm2;
                bm1 = [self.c[0]];
            }
        }

        function invalidCopyOutTwo(map<boolean>[] boolMaps) {
            map<boolean> bm1 = {};
            lock {
                map<boolean> bm2 = {};
                lock {
                    map<boolean> bm3 = boolMaps[0].clone();
                    bm1 = bm3;
                }

                globBoolMap = self.c[0];
                bm1 = bm2;
            }
        }
    };
}
