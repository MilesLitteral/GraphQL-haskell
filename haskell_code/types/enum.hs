import Graphene.Utils.Subclass_With_Meta  (SubclassWithMeta_Meta)
import Graphene.Base (BaseOptions, BaseType)
import Graphene.Types.UnmountedType (UnmountedType)

{-
    Enum type definition

    Defines a static set of values that can be provided as a Field, Argument or InputField.

    .. code:: python

        from graphene import Enum

        class NameFormat(Enum):
            FIRST_LAST = "first_last"
            LAST_FIRST = "last_first"

    Meta:
        enum (optional, Enum): Python enum to use as a base for GraphQL Enum.

        name (optional, str): Name of the GraphQL type (must be unique in schema). Defaults to class
            name.
        description (optional, str): Description of the GraphQL type in the schema. Defaults to class
            docstring.
        deprecation_reason (optional, str): Setting this value indicates that the enum is
            depreciated and may provide instruction or reason on how for clients to proceed.
-}

type EnumOptions = BaseOptions 

data EnumType = EnumType{ value :: GraphQLEnum, grapheneType :: GraphQLType, type_description :: Maybe Text, deprecation_reason :: Maybe Text } deriving(Show, Eq, Enum)

class EnumMeta a where -- noqa: N805
    new           :: EnumType -> SubclassWithMeta_Meta
    get           :: SubclassWithMeta_Meta
    getItemValue  :: SubclassWithMeta_Meta -> GraphQLEnum
    prepare       :: GraphQLEnum
    call          :: SubclassWithMeta_Meta -> EnumType -- Pattern Matching
    from_enum     :: SubclassWithMeta_Meta -> EnumType

-- instance Traversable items where 
