module Graphene.Types.Decimal where 
    
import GraphQL.Decimal as _Decimal
import GraphQL.Language.AST (StringValueNode, IntValueNode)
import GraphQL.Scalars(Scalar)

{-
    The `Decimal` scalar type represents a Haskell Fractional.
-}

--This thing always is just for Scalar
newtype Decimal = Decimal {
    value :: Scalar
} deriving (Show, Eq)

class IsDecimal s where
    serialize     :: Scalar a => Int      -> Time
    parse_literal :: Scalar a => Constant -> Time
    parse_value   :: Scalar a => Int      -> Time