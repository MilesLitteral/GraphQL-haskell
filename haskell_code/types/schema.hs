module GraphQL.Schema where 

import GraphQL (
        default_type_resolver,
        get_introspection_query,
        graphql,
        graphql_sync,
        introspection_types,
        parse,
        print_schema,
        subscribe,
        validate,
        ExecutionResult,
        GraphQLArgument,
        GraphQLBoolean,
        GraphQLError,
        GraphQLEnumValue,
        GraphQLField,
        GraphQLFloat,
        GraphQLID,
        GraphQLInputField,
        GraphQLInt,
        GraphQLList,
        GraphQLNonNull,
        GraphQLObjectType,
        GraphQLSchema,
        GraphQLString
    )

import GraphQL.Dynamic
import GraphQL.Enum 
import GraphQL.Field
import GraphQL.InputObjectType
import GraphQL.Interface
import GraphQL.ObjectType
import GraphQL.Resolver   (get_default_resolver)
import GraphQL.Scalars    (ID, Boolean, Float, Int, Scalar, String)
import GraphQL.Structures (List, NonNull)
import GraphQL.Union
import GraphQL.Utils (get_field_as)
import GraphQL.Utils.Converters  (to_camel_case)
import GraphQL.Utils.Get_Unbound_Function (get_unbound_function)

import Graphene.Utils (inspect, functools, partial)
import Graphene.Definitions (
        GrapheneEnumType,
        GrapheneGraphQLType,
        GrapheneInputObjectType,
        GrapheneInterfaceType,
        GrapheneObjectType,
        GrapheneScalarType,
        GrapheneUnionType
    )

{-
    Schema Definition.
    A Graphene Schema can execute operations (query, mutation, subscription) against the defined
    types. For advanced purposes, the schema can be used to lookup type definitions and answer
    questions about the types through introspection.
    Args:
        query (Type[ObjectType]): Root query *ObjectType*. Describes entry point for fields to *read*
            data in your Schema.
        mutation (Optional[Type[ObjectType]]): Root mutation *ObjectType*. Describes entry point for
            fields to *create, update or delete* data in your API.
        subscription (Optional[Type[ObjectType]]): Root subscription *ObjectType*. Describes entry point
            for fields to receive continuous updates.
        types (Optional[List[Type[ObjectType]]]): List of any types to include in schema that
            may not be introspected through root types.
        directives (List[GraphQLDirective], optional): List of custom directives to include in the
            GraphQL schema. Defaults to only include directives defined by GraphQL spec (@include
            and @skip) [GraphQLIncludeDirective, GraphQLSkipDirective].
        auto_camelcase (bool): Fieldnames will be transformed in Schema's TypeMap from snake_case
            to camelCase (preferred by GraphQL standard). Default True.
-}

data Schema = Schema {
    initialize               :: GraphQLSchema,
    lazy                     :: GrapheneType,
    __str__                  :: GrapheneType -> Text,
    __getattr__              :: GrapheneType,
    execute                  :: GraphQL,
    execute_async            :: GraphQL,
    subscribe                :: ExecutionResult,
    normalize_execute_kwargs :: ExecutionResult
} deriving(Show, Eq)

type IntrospectionQuery  = get_introspection_query
type IntrospectionSchema = introspection_types --Schema

-- We have a mapping to the original GraphQL types
-- so there are no collisions.
class TypeMap dict where
    initialize             :: Map
    add_type               :: GrapheneType --(self, graphene_type):
    create_scalar          :: GrapheneType -> Scalar
    create_enum            :: GrapheneType -> Enum
    create_objecttype      :: GrapheneType -> Object --Haskell People about to get mad lmfao
    create_interface       :: GrapheneInterfaceType
    create_inputobjecttype :: GrapheneInputObjectType
    construct_union        :: GrapheneUnionType
    get_name               :: Text
    create_fields_for_type :: [GraphQLField]
    get_function_for_type  :: GrapheneType -> Text
    resolve_type           :: GrapheneType

assert_valid_root_type :: Constant -> GraphQLObjectType
assert_valid_root_type type_ = do
    if type_ is None 
        then return Nothing
        else let is_graphene_objecttype = inspect.isclass(type_) && issubclass(type_, ObjectType) 
        assert (is_graphene_objecttype || is_graphql_objecttype) "Type {type_} is not a valid ObjectType."

is_graphene_type ::   Constant ->  GrapheneScalarType
is_graphene_type type_ =
    if IsInstance(type_, (List, NonNull))
        then return True
    if inspect.isclass(type_) and issubclass(type_, (ObjectType, InputObjectType, Scalar, Interface, Union, Enum)
        then return True

is_type_of_from_possible_types :: Scalar -> [Scalar]
is_type_of_from_possible_types possible_types, root, _info = return isinstance(root, possible_types)

-- We use this resolver for subscriptions
identity_resolve :: Scalar
identity_resolve root, info, **arguments = return root
