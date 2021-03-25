import ballerina/lang.'object;

class IterableImpl {
    *object:Iterable;
    public function iterator() returns object {public isolated function next() returns record {|int value;|}?;
    } {
        InternalIterable sample = new;
        return sample;
    }
}

public function testIterableObject() returns int[] {
    IterableImpl p = new IterableImpl();
    int[] integers = [];
    foreach var item in p {
        integers.push(item);
    }

    return integers;
}

class InternalIterable {
   int[] integers = [12, 34, 56, 34, 78, 21, 90];
   int cursorIndex = 0;
   public isolated function next() returns
   record {|
       int value;
   |}? {
       self.cursorIndex += 1;
       if (self.cursorIndex <= 7) {
           return {
               value: self.integers[self.cursorIndex - 1]
           };
       } else {
           return ();
       }
   }
}

class AnotherIterable {
    *object:Iterable;
    public function iterator() returns object {public isolated function next() returns record {|IterableImpl value;|}?;
    } {
        AnotherInternalIterable sample = new;
        return sample;
    }
}

class AnotherInternalIterable {
    int cursorIndex = 0;
    public isolated function next() returns
    record {|
        IterableImpl value;
    |}? {
        self.cursorIndex += 1;
        if (self.cursorIndex <= 2) {
            return {
                value: new IterableImpl()
            };
        } else {
            return ();
        }
    }
}

public function testNestedIterableObject() returns int[] {
    AnotherIterable p = new AnotherIterable();
    int[] integers = [];
    foreach var itr in p {
        foreach var item in itr {
            integers.push(item);
        }
    }

    return integers;
}

public function testIterableObjectReturnedByRangeExpression() {
    object {
        public isolated function iterator() returns object {
                public isolated function next() returns record {| int value; |}?;
            };
    } objectResult = 1...3;
    int[] integers = [];
    var iterator = objectResult.iterator();
    var nR1 = iterator.next();
    if (nR1 is record {| int value; |}) {
        integers.push(nR1.value);
    }
    nR1 = iterator.next();
    if (nR1 is record {| int value; |}) {
        integers.push(nR1.value);
    }
    nR1 = iterator.next();
    if (nR1 is record {| int value; |}) {
        integers.push(nR1.value);
    }
    assert(integers, [1, 2, 3]);
}

public function testIterableDistinctObjectReturnedByRangeExpression() {
    var objectResult = 1...3;
    int[] integers = [];
    foreach var item in objectResult {
        integers.push(item);
    }
    assert(integers, [1, 2, 3]);
}

function assert(anydata actual, anydata expected) {
    if (expected != actual) {
        typedesc<anydata> expT = typeof expected;
        typedesc<anydata> actT = typeof actual;
        string reason = "expected [" + expected.toString() + "] of type [" + expT.toString()
                            + "], but found [" + actual.toString() + "] of type [" + actT.toString() + "]";
        error e = error(reason);
        panic e;
    }
}
