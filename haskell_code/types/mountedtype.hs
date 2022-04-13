import GraphQL.Utils.OrderedType  (OrderedType)
import GraphQL.Types.UnmountedType (UnmountedType)

{-
    Mount the UnmountedType instance
-}

instance MountedType OrderedType where
    mounted unmounted  = assert $ isinstance(unmounted, UnmountedType)
     --f"{cls.__name__} can't mount {repr(unmounted)}" -- # noqa: N802

