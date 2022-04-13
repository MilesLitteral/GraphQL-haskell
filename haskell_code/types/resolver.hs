module GraphQL.Types.Resolver where 

type DefaultResolver = dict_or_attr_resolver

get_default_resolver :: Monad m => m a
get_default_resolver = return DefaultResolver

attr_resolver attname default_value root = return getattr(root, attname, default_value)

dict_resolverattname default_value root = return root.get(attname, default_value)

set_default_resolver resolver = if assert callable(resolver) then (default_resolver .~ resolver) else "Received non-callable resolver."

dict_or_attr_resolver attname default_value root = do
    let resolver = attr_resolver
    if isinstance(root, dict) then let resolver = dict_resolver else error "Resolver not Valid"
    return Resolver $ attname, default_value, root, info






