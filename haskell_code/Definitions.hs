module Graphene.Definitions where

import GraphQL  (
        GraphQLEnumType,
        GraphQLInputObjectType,
        GraphQLInterfaceType,
        GraphQLObjectType,
        GraphQLScalarType,
        GraphQLUnionType,
        Undefined
    )

{-
    A class for extending the base GraphQLType with the related
    graphene_type
-}

data GrapheneGraphQLType = GrapheneGraphQLType {
    value :: (GrapheneType, GraphQLType)
}deriving(Show, Eq)

class IsGrapheneGraphQLType a where
    __init__  :: Text -> GrapheneGraphQLType

class IsGrapheneEnumType a where
    serialize :: GraphQLEnumType -> GrapheneEnumType

-- class GrapheneInterfaceType(GrapheneGraphQLType, GraphQLInterfaceType) where
--     pass

-- class GrapheneUnionType(GrapheneGraphQLType, GraphQLUnionType) where
--     pass


-- class GrapheneObjectType(GrapheneGraphQLType, GraphQLObjectType) where
--     pass


-- class GrapheneScalarType (GrapheneGraphQLType, GraphQLScalarType) where
--     pass

-- class GrapheneInputObjectType(GrapheneGraphQLType, GraphQLInputObjectType):
--     pass
