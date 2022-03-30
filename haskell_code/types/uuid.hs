import GraphQL.UUID (UUID)
import GraphQL.Language.AST (StringValueNode)
import GraphQL.Scalars (Scalar)
--from __future__ import absolute_import

{-
    Leverages the internal Haskell implementation of UUID (uuid.UUID) to provide native UUID objects
    in fields, resolvers and input.
-}

data UUID = UUID {value :: Scalar} deriving (Show, Eq)

class UUIDInterface uuid where  
    deSerialize     :: Scalar
    parse_literal   :: StringValueNode -> UUID
    parse_value     :: Scalar -> UUID
