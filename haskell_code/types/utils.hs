module GraphQL.Utils where

import GraphQL.Utils.Module_Loading (string)
import GraphQL.Utils.MountedType    (MountedType)
import GraphQL.Utils.UnmountedType  (UnmountedType)
import Graphene.Utils (inspect, functools, partial)

{-
    Get type mounted
-}

get_field_as :: GraphQLField -> GraphQLObjectType
get_field_as value as = do
    if isinstance value MountedType
        then return value
    if isinstance value UnmountedType
        then if _as is None 
            then return value
            else return _as.mounted(value)

{-
    Extract all the fields in given attributes (dict)
    and return them ordered
-}
yank_fields_from_attrs :: GraphQLField
yank_fields_from_attrs attrs _as sort = do
    let fields_with_names = []
    for attname, value in list(attrs.items()):
        field = get_field_as(value, _as)
        if not field:
            continue
        fields_with_names.append((attname, field))

    if sort:
        fields_with_names = sorted(fields_with_names, key=lambda f: f[1])
    return dict(fields_with_names)

get_type :: GraphQLObjectType
get_type _type = do
    if isinstance(_type, str)
        then return import_string(_type)
        else if inspect.isfunction(_type) or isinstance(_type, partial):
            then return _type()
            else return _type

-- Get the underlying type even if it is wrapped in structures like NonNull
get_underlying_type :: GraphQLObjectType
get_underlying_type _type = do
    if hasattr(_type, "of_type") == True
        then _type = _type.of_type
        else return _type
