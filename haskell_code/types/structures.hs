import Graphene.UnmountedType
import Graphene.Utils (get_type)

{-
    A structure is a GraphQL type instance that
    wraps a main type with certain structure.
-}

data Structure = Structure{
    initialize :: Structure, --(self, of_type, *args, **kwargs):
    of_type    :: GraphQLObjectType
} deriving(Show, Eq)

{-
    List Modifier

    A list is a kind of type marker, a wrapping type which points to another
    type. Lists are often created within the context of defining the fields of
    an object type.

    List indicates that many values will be returned (or input) for this field.

    .. code:: python

        from graphene import List, String

        field_name = List(String, description="There will be many values")
-}

class List structure where
    __str__ :: Text
    __eq___ :: Bool


class NonNull structure where
    __init__ :: Structure
    __str__  :: Text
    __eq__   :: Bool
