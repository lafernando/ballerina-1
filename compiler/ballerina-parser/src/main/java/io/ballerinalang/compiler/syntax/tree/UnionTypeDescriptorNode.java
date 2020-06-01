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
package io.ballerinalang.compiler.syntax.tree;

import io.ballerinalang.compiler.internal.parser.tree.STNode;

import java.util.Objects;

/**
 * This is a generated syntax tree node.
 *
 * @since 2.0.0
 */
public class UnionTypeDescriptorNode extends TypeDescriptorNode {

    public UnionTypeDescriptorNode(STNode internalNode, int position, NonTerminalNode parent) {
        super(internalNode, position, parent);
    }

    public TypeDescriptorNode leftTypeDesc() {
        return childInBucket(0);
    }

    public Token pipeToken() {
        return childInBucket(1);
    }

    public TypeDescriptorNode rightTypeDesc() {
        return childInBucket(2);
    }

    @Override
    public void accept(NodeVisitor visitor) {
        visitor.visit(this);
    }

    @Override
    public <T> T apply(NodeTransformer<T> visitor) {
        return visitor.transform(this);
    }

    @Override
    protected String[] childNames() {
        return new String[]{
                "leftTypeDesc",
                "pipeToken",
                "rightTypeDesc"};
    }

    public UnionTypeDescriptorNode modify(
            TypeDescriptorNode leftTypeDesc,
            Token pipeToken,
            TypeDescriptorNode rightTypeDesc) {
        if (checkForReferenceEquality(
                leftTypeDesc,
                pipeToken,
                rightTypeDesc)) {
            return this;
        }

        return NodeFactory.createUnionTypeDescriptorNode(
                leftTypeDesc,
                pipeToken,
                rightTypeDesc);
    }

    public UnionTypeDescriptorNodeModifier modify() {
        return new UnionTypeDescriptorNodeModifier(this);
    }

    /**
     * This is a generated tree node modifier utility.
     *
     * @since 2.0.0
     */
    public static class UnionTypeDescriptorNodeModifier {
        private final UnionTypeDescriptorNode oldNode;
        private TypeDescriptorNode leftTypeDesc;
        private Token pipeToken;
        private TypeDescriptorNode rightTypeDesc;

        public UnionTypeDescriptorNodeModifier(UnionTypeDescriptorNode oldNode) {
            this.oldNode = oldNode;
            this.leftTypeDesc = oldNode.leftTypeDesc();
            this.pipeToken = oldNode.pipeToken();
            this.rightTypeDesc = oldNode.rightTypeDesc();
        }

        public UnionTypeDescriptorNodeModifier withLeftTypeDesc(
                TypeDescriptorNode leftTypeDesc) {
            Objects.requireNonNull(leftTypeDesc, "leftTypeDesc must not be null");
            this.leftTypeDesc = leftTypeDesc;
            return this;
        }

        public UnionTypeDescriptorNodeModifier withPipeToken(
                Token pipeToken) {
            Objects.requireNonNull(pipeToken, "pipeToken must not be null");
            this.pipeToken = pipeToken;
            return this;
        }

        public UnionTypeDescriptorNodeModifier withRightTypeDesc(
                TypeDescriptorNode rightTypeDesc) {
            Objects.requireNonNull(rightTypeDesc, "rightTypeDesc must not be null");
            this.rightTypeDesc = rightTypeDesc;
            return this;
        }

        public UnionTypeDescriptorNode apply() {
            return oldNode.modify(
                    leftTypeDesc,
                    pipeToken,
                    rightTypeDesc);
        }
    }
}
