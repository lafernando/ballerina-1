/*
 *  Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package org.ballerinalang.langserver.completion.latest;

import org.testng.annotations.DataProvider;

/**
 * Expression Context tests.
 * 
 * @since 2.0.0
 */
public class ExpressionContextTest extends CompletionTestNew {
    @DataProvider(name = "completion-data-provider")
    @Override
    public Object[][] dataProvider() {
        return this.getConfigsList();
    }

    @Override
    public Object[][] testSubset() {
         // Enable the following in order to test a subset of test cases
          return new Object[][] {
                  {"list_constructor_ctx_config1.json", this.getTestResourceDir()},
                  {"list_constructor_ctx_config2.json", this.getTestResourceDir()},
                  {"list_constructor_ctx_config3.json", this.getTestResourceDir()},
                  {"var_ref_ctx_config1.json", this.getTestResourceDir()},
                  {"var_ref_ctx_config2.json", this.getTestResourceDir()},
                  {"var_ref_ctx_config3.json", this.getTestResourceDir()},
                  {"var_ref_ctx_config4.json", this.getTestResourceDir()},
                  {"var_ref_ctx_config5.json", this.getTestResourceDir()},
                  {"field_access_ctx_config1.json", this.getTestResourceDir()},
                  {"field_access_ctx_config2.json", this.getTestResourceDir()},
                  {"field_access_ctx_config3.json", this.getTestResourceDir()},
                  {"field_access_ctx_config4.json", this.getTestResourceDir()},
                  {"optional_field_access_ctx_config1.json", this.getTestResourceDir()},
                  {"optional_field_access_ctx_config2.json", this.getTestResourceDir()},
                  {"optional_field_access_ctx_config3.json", this.getTestResourceDir()},
                  {"typeof_expression_ctx_config1.json", this.getTestResourceDir()},
                  {"typeof_expression_ctx_config2.json", this.getTestResourceDir()},
                  {"type_test_expression_ctx_config1.json", this.getTestResourceDir()},
                  {"type_test_expression_ctx_config2.json", this.getTestResourceDir()},
                  {"type_test_expression_ctx_config3.json", this.getTestResourceDir()},
                  {"type_test_expression_ctx_config4.json", this.getTestResourceDir()},
          };
//        return new Object[0][];
    }

    @Override
    public String getTestResourceDir() {
        return "expression_context";
    }
}