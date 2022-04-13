import  GraphQL (Undefined)
import  GraphQL.Types.MountedType (MountedType)
import  GraphQL.Types.Structures (NonNull)
import  GraphQL.Utils      (get_type)
import  GraphQL.Types

class IsInputField mount where
    initialize :: GraphQL.Types.InputField
    ofType     :: GrapheneType
