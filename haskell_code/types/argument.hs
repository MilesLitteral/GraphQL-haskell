module Graphene.Types.Argument where

import Graphene.Types.Dynamic       (Dynamic)
import Graphene.Types.MountedType   (MountedType)
import Graphene.Types.Structures    (NonNull)
import Graphene.Types.Utils         (get_type)
import Graphene.Types.UnmountedType (UnmountedType)
import Graphene.Types.Field         (Field)
import Graphene.Types.InputField    (InputField)

-- from itertools import chain

{-
    Makes an Argument available on a Field in the GraphQL schema.

    Arguments will be parsed and provided to resolver methods for fields as keyword arguments.

    All ``arg`` and ``**extra_args`` for a ``graphene.Field`` are implicitly mounted as Argument
    using the below parameters.

    .. code:: python

        from graphene import String, Boolean, Argument

        age = String(
            # Boolean implicitly mounted as Argument
            dog_years=Boolean(description="convert to dog years"),
            # Boolean explicitly mounted as Argument
            decades=Argument(Boolean, default_value=False),
        )

    args:
        type (class for a graphene.UnmountedType): must be a class (not an instance) of an
            unmounted graphene type (ex. scalar or object) which is used for the type of this
            argument in the GraphQL schema.
        required (bool): indicates this argument as not null in the graphql schema. Same behavior
            as graphene.NonNull. Default False.
        name (str): the name of the GraphQL argument. Defaults to parameter name.
        description (str): the description of the GraphQL argument in the schema.
        default_value (Any): The value to be provided if the user does not set this argument in
            the operation.
-}

newtype Argument = Argument {
    value :: Scalar
} deriving(Show, Eq)

--(MountedType):
class IsArgument mt where
    __init__     :: Text -> Argument
    get_type     :: GrapheneType --(self._type)
    __eq__       :: Bool
    to_arguments :: Text -> [GraphQLField]

