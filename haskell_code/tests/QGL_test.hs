module GraphQL.Demo.Tests

where

import GraphQL.Promise (Promise, is_thenable)
import GraphQL.Error (format_error, GraphQLError)
import Graphene.Types.Schema (Schema)

data Client = Client {
    formatResult :: GraphQLResponse,
    execute      :: Promise
}

default_format_error :: GraphQLError -> Map k a
default_format_error err = do
    if IsInstance error GraphQLError
        then return $ format_error error
        else return $ fromList [("message": error)]

format_execution_result :: GraphQLResult -> GraphQLError -> GraphQLResponse
format_execution_result execution_result format_error = do
    if execution_result & execution_result ! errors == Nothing then let response = Nothing else let response = [format_error(e) for e in execution_result.errors] --execution_result !! errors 
    --let response = unData execution_result
    return response