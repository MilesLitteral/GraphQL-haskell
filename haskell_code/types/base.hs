module GraphQL.Base where 
import GraphQL.Utils (SubclassWithMeta, SubclassWithMeta_Meta, trim_docstring)


class BaseOptions opts where
    __init__    :: name = None         -- type: str
    freeze      :: self._frozen = Tru
    __setattr__ :: (self, name, value)
    __repr__    :: description = None  -- type: str
    _frozen = False  -- type: bool


class BaseType meta where
    create_type                 :: GraphQLObjectType
    __init_subclass_with_meta__ :: SubclassWithMeta
