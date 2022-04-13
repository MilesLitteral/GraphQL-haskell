import GraphQL.Language.AST (StringValueNode)
import GraphQL.Types.Scalars  (Scalar)

{-    
    Allows use of a JSON String for input / output from the GraphQL schema.

    Use of this type is *not recommended* as you lose the benefits of having a defined, static
    schema (one of the key benefits of GraphQL).
-}

class JSONString t where
    serialize     :: String      -> JSON
    parse_literal :: Value       -> JSON
    parse_value   :: Maybe Value -> JSON

{-    
    Allows use of a JSON String for input / output from the GraphQL schema.
    Use of this type is *not recommended* as you lose the benefits of having a defined, static
    schema (one of the key benefits of GraphQL).
-}
instance JSONString Scalar where
    serialize dt = return $ dumps dt
    parse_literal node = if isinstance(node StringValueNode) then return loads $ unValue node else return Nothing
    parse_value value  = return loads(value)
