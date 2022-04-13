import GraphQL.Types.Base (BaseOptions, BaseType, BaseTypeMeta)
import GraphQL.Types.Field (Field)
import GraphQL.Types.Interface  (Interface)
import GraphQL.Utils (yank_fields_from_attrs)

-- try:
--     from dataclasses import make_dataclass, field
-- except ImportError:
--     from ..pyutils.dataclasses import make_dataclass, field  # type: ignore
-- # For static type checking with Mypy
-- MYPY = False
-- if MYPY:
--     from typing import Dict, Iterable, Type  # NOQA

type ObjectTypeMeta = BaseTypeMeta 

data ObjectTypeOptions =
    ObjectTypeOptions{ 
        fields      :: [(String, Field)],   -- # type: Dict[str, Field]
        interfaces  :: [Type[Interface]] -- # type: Iterable[Type[Interface]]
    }

instance Meta ObjectType where
   subclassWithMeta interfaces possible_types = map (\n -> replicate n possible_types) interfaces
