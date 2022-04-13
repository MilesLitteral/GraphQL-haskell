module GraphQL.Types.InputObjectType where 

import GraphQL.Types.Base(BaseOptions, BaseType)
import GraphQL.Types.InputField (InputField)
import GraphQL.Types.UnmountedType (UnmountedType)
import Graphene.Utils (yank_fields_from_attrs)

-- # For static type checking with Mypy
-- MYPY = False
-- if MYPY:
--     from typing import Dict, Callable  # NOQA 

class Meta inputObject where
    initialize :: [[InputObjectTypeContainer]]

data InputObjectTypeOptions = 
    InputObjectTypeOptions {
        fields    :: [(str, InputField)],      -- type: Dict[str, InputField]
        container :: InputObjectTypeContainer  -- type: InputObjectTypeContainer
    } deriving(Show, Eq)

--class Meta obj where
instance Meta InputObjectTypeContainer where
    initialize keys fields = map (\key -> replicate key fields) keys

