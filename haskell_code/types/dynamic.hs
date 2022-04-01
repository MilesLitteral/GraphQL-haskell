import GraphQL.Utilities (inspect)
import GraphQL.Utilities.FunctionTools (partial)
import Graphene.Types.MountedType (MountedType)

{-
    A Dynamic Type let us get the type in runtime when we generate
    the schema. So we can have lazy fields.
-}

class Dynamic t where
    initialize  :: GrapheneType -> Dynamic
    get_type    :: Dynamic -> GrapheneType 
    

--instance Dynamic MountedType where