module Graphene.Types.DateTime where
    
import GraphQL.Error    (GraphQLError)
import GraphQL.Language (StringValueNode, print_ast)
import GraphQL.Scalars (Scalar)

-- from __future__ import absolute_import
-- import datetime
-- from aniso8601 import parse_date, parse_datetime, parse_time

{-
    The `Date` scalar type represents a Date
    value as specified by
    [iso8601](https://en.wikipedia.org/wiki/ISO_8601).
-}

class IsDate d where
    serialize     :: Scalar a => Date
    parse_literal :: Scalar a => Constant -> Date
    parse_value   :: Scalar a => Int      -> Date

{-
    The `Time` scalar type represents a Time value as
    specified by
    [iso8601](https://en.wikipedia.org/wiki/ISO_8601).
-}
class IsTime t where
    serialize     :: Scalar a => Int      -> Time
    parse_literal :: Scalar a => Constant -> Time
    parse_value   :: Scalar a => Int      -> Time

data Date = Date{
    year  :: Int,
    month :: Int,
    day   :: Int,
    time  :: Scalar
} deriving(Show, Eq)

newtype Time = Time {time  :: Scalar} deriving(Show, Eq)