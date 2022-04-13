import Graphene.Utils (inspect, get_type)
import Graphene.Utils.FuncTools (partial)
import Graphene.Types.Argument (Argument, to_arguments)
import Graphene.Types.MountedType
import Graphene.Types.Resolver (default_resolver)
import Graphene.Types.Structures  (NonNull)
import Graphene.Types.UnmountedType (UnmountedType)
import Graphene.Utils.Deprecated (warn_deprecation)

{-
    Makes a field available on an ObjectType in the GraphQL schema. Any type can be mounted as a
    Field:

    - Object Type
    - Scalar Type
    - Enum
    - Interface
    - Union

    All class attributes of ``graphene.ObjectType`` are implicitly mounted as Field using the below
    arguments.

    .. code:: python

        class Person(ObjectType):
            first_name = graphene.String(required=True)                # implicitly mounted as Field
            last_name = graphene.Field(String, description='Surname')  # explicitly mounted as Field

    args:
        type (class for a graphene.UnmountedType): Must be a class (not an instance) of an
            unmounted graphene type (ex. scalar or object) which is used for the type of this
            field in the GraphQL schema.
        args (optional, Dict[str, graphene.Argument]): Arguments that can be input to the field.
            Prefer to use ``**extra_args``, unless you use an argument name that clashes with one
            of the Field arguments presented here (see :ref:`example<ResolverParamGraphQLArguments>`).
        resolver (optional, Callable): A function to get the value for a Field from the parent
            value object. If not set, the default resolver method for the schema is used.
        source (optional, str): attribute name to resolve for this field from the parent value
            object. Alternative to resolver (cannot set both source and resolver).
        deprecation_reason (optional, str): Setting this value indicates that the field is
            depreciated and may provide instruction or reason on how for clients to proceed.
        required (optional, bool): indicates this field as not null in the graphql schema. Same behavior as
            graphene.NonNull. Default False.
        name (optional, str): the name of the GraphQL field (must be unique in a type). Defaults to attribute
            name.
        description (optional, str): the description of the GraphQL field in the schema.
        default_value (optional, Any): Default value to resolve if none set from schema.
        **extra_args (optional, Dict[str, Union[graphene.Argument, graphene.UnmountedType]): any
            additional arguments to mount on the field.
-}

base_type = type
def source_resolver(source, root, info, **args):
    resolved = default_resolver(source, None, root, info, **args)
    if inspect.isfunction(resolved) or inspect.ismethod(resolved):
        return resolved()
    return resolved


class IsField mounted where
        initialize     :: mounted -> Field
        getType        :: mounted
        get_resolver   :: Resolver
        wrap_resolve   :: mounted -> Resolver 
        wrap_subscribe :: mounted -> f mounted
 
