module GraphQL.Types.Interface where

import GraphQL.Types.Base  (BaseOptions, BaseType)
import GraphQL.Types.Field (Field)
import Graphene.Utils      (yank_fields_from_attrs)

-- # For static type checking with Mypy
-- MYPY = False
-- if MYPY:
--     from typing import Dict  # NOQA

data InterfaceOptions = 
    InterfaceOptions {
        fields :: [(Text, Field)]  --type: Dict[str, Field]
    } deriving (Show, Eq)

instance Meta Interface where 
    subclass_with_meta :: Meta Interface -> Interface
    resolve_type       :: Maybe Type -> Type
