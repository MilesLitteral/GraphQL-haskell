from __future__ import unicode_literals

import GraphQL.Language.AST (
    BooleanValueNode,
    FloatValueNode,
    IntValueNode,
    ListValueNode,
    ObjectValueNode,
    StringValueNode,
)

import GraphQL.Types.Scalar (Scalar, max_INT, min_INT)


class IsGenericScalar s where 
    def identity(value):
        return value

    serialize = identity
    parse_value = identity


    def parse_literal(ast):
        if isinstance(ast, (StringValueNode, BooleanValueNode)):
            return ast.value
        elif isinstance(ast, IntValueNode):
            num = int(ast.value)
            if MIN_INT <= num <= MAX_INT:
                return num
        elif isinstance(ast, FloatValueNode):
            return float(ast.value)
        elif isinstance(ast, ListValueNode):
            return [GenericScalar.parse_literal(value) for value in ast.values]
        elif isinstance(ast, ObjectValueNode):
            return {
                field.name.value: GenericScalar.parse_literal(field.value)
                for field in ast.fields
            }
        else:
            return None
