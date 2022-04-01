import GraphQL (Undefined)
import  GraphQL.MountedType (MountedType)
import  GraphQL.Structures (NonNull)
import  GraphQL.Utils      (get_type)
import  GraphQL.Types

class IsInputField mount where
    __init__ :: GraphQL.Types.InputField
    ofType     :: GrapheneType
