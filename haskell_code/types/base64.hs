import GraphQL.Error   (GraphQLError)
import GraphQL.Language (StringValueNode, print_ast)
import GraphQL.Scalars  (Scalar)

-- from binascii import Error as _Error
-- from base64 import b64decode, b64encode

{-
    The `Base64` scalar type represents a base64-encoded String.
-}
class IsBase64 base where
        serialize     ::
        parse_literal ::
        parse_value   :: (value):
