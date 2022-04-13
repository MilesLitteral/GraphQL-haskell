module GraphQL.Types.Mutation where 

import Graphene.Utils.Deprecated (warn_deprecation)
import Graphene.Utils.Get_Unbound_Function (get_unbound_function)
import Graphene.Utils.Props (props)
import GraphQL.Types.Field (Field)
import GraphQL.Types.ObjectType (ObjectType, ObjectTypeOptions)
import GraphQL.Utils (yank_fields_from_attrs)
import GraphQL.Types.Interface (Interface)

-- # # For static type checking with Mypy
-- # MYPY = False
-- # if MYPY:
-- #     from .argument import Argument  # NOQA
-- #     from typing import Dict, Type, Callable, Iterable  # NOQA

data MutationOptions =
    MutationOptions{
        arguments  :: [(String, Argument)],
        output     :: [ObjectType],
        resolver   :: Resolver,
        interfaces :: [Type[Interface]]
    } deriving(Show, Eq)


class Mutation objectType where
    subclassWithMeta :: objectType -> Mutation
    addField :: objectType -> Mutation -> Field
