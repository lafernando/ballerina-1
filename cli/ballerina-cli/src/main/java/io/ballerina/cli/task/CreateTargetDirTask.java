/*
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.cli.task;

import io.ballerina.projects.Project;
import io.ballerina.projects.model.Target;
import io.ballerina.projects.utils.ProjectUtils;
import org.wso2.ballerinalang.util.RepoUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import static org.ballerinalang.tool.LauncherUtils.createLauncherException;

/**
 * Create the target directory.
 */
public class CreateTargetDirTask implements Task {
    
    @Override
    public void execute(Project project) {
        Target target = new Target(project.sourceRoot());
        try {
            if (Files.notExists(target.path())) {
                Files.createDirectories(target.path());
            }
            // We create a home repo if home repo path not exists
            Path homeRepo = RepoUtils.createAndGetHomeReposPath();
            Files.createDirectories(homeRepo);
            Files.createDirectories(ProjectUtils.getBaloCacheFromHome());
            Files.createDirectories(ProjectUtils.getBirCacheFromHome());
            Files.createDirectories(ProjectUtils.getJarCacheFromHome());
        } catch (IOException e) {
            throw createLauncherException("unable to create target directory: " + target.path());
        }
    }
}
