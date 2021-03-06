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

import ballerina/http;
import ballerina/observe;
import ballerina/observe.mockextension;
import ballerina/testobserve;

@http:ServiceConfig {
    basePath:"/mock-tracer"
}
service mockTracer on new http:Listener(19090) {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/spans/{serviceName}"
    }
    resource function getMockTraces(http:Caller caller, http:Request clientRequest, string serviceName) {
        mockextension:Spans[] spans = mockextension:getFinishedSpans(serviceName);
        json spansJson = checkpanic spans.cloneWithType(json);
        http:Response res = new;
        res.setJsonPayload(spansJson);
        checkpanic caller->respond(res);
    }
}
