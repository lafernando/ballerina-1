/*
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.ballerinalang.stdlib.system.nativeimpl;

import org.ballerinalang.jvm.scheduling.Strand;
import org.ballerinalang.jvm.values.ObjectValue;
import org.ballerinalang.model.types.TypeKind;
import org.ballerinalang.natives.annotations.BallerinaFunction;
import org.ballerinalang.natives.annotations.Receiver;
import org.ballerinalang.natives.annotations.ReturnType;
import org.ballerinalang.stdlib.system.utils.SystemConstants;
import org.ballerinalang.stdlib.system.utils.SystemUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * External function for ballerina.system:Process.exitCode.
 *
 * @since 1.0.0
 */
@BallerinaFunction(
        orgName = SystemConstants.ORG_NAME,
        packageName = SystemConstants.PACKAGE_NAME,
        functionName = "exitCode",
        receiver = @Receiver(type = TypeKind.OBJECT, structType = "Process",
        structPackage = "ballerina/system"),
        returnType = { @ReturnType(type = TypeKind.INT), @ReturnType(type = TypeKind.ERROR) }
)
public class ExitCode {
    
    private static final Logger log = LoggerFactory.getLogger(WaitForExit.class);

    public static Object exitCode(Strand strand, ObjectValue objVal) {
        Process process = SystemUtils.processFromObject(objVal);
        try {
            return process.exitValue();
        } catch (java.lang.IllegalThreadStateException e) {
            log.error("Error while getting process exit code", e);
            return SystemUtils.getBallerinaError(SystemConstants.PROCESS_EXEC_ERROR, e);
        }
    }

}
