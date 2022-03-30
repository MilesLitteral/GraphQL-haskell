module GraphQL.Utils.UnmountedType where
    
import GraphQL.Utils.OrderedType 

{-
    This class acts a proxy for a Graphene Type, so it can be mounted
    dynamically as Field, InputField or Argument.

    Instead of writing:

    .. code:: python

        from graphene import ObjectType, Field, String

        class MyObjectType(ObjectType):
            my_field = Field(String, description='Description here')

    It lets you write:

    .. code:: python

        from graphene import ObjectType, String

        class MyObjectType(ObjectType):
            my_field = String(description='Description here')

    It is not used directly, but is inherited by other types and streamlines their use in
    different context:

    - Object Type
    - Scalar Type
    - Enum
    - Interface
    - Union

    An unmounted type will accept arguments based upon its context (ObjectType, Field or
    InputObjectType) and pass it on to the appropriate MountedType (Field, Argument or InputField).

    See each Mounted type reference for more information about valid parameters.
-}

class UnmountedType where
    __init__   :: OrderedType
    get_type   :: OrderedType
    mount_as   :: OrderedType
    field      :: GraphQLField
    inputField :: GraphQLInputField
    argument   :: GraphQLArgument
    __eq__     :: Bool
