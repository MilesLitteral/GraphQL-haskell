module GraphQL.Demo.Tests

where

import GraphQL.Promise (Promise, is_thenable)
import GraphQL.Error (format_error, GraphQLError) --as format_graphql_error
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
    if execution_result & execution_result ! errors == Nothing
        then let response = Nothing 
        else let response = [format_error(e) for e in execution_result.errors] --execution_result !! errors 
    let response = unData execution_result


class Client:
    def __init__(self, schema, format_error=None, **execute_options):
        assert isinstance(schema, Schema)
        self.schema = schema
        self.execute_options = execute_options
        self.format_error = format_error or default_format_error

    def format_result(self, result):
        return format_execution_result(result, self.format_error)

    def execute(self, *args, **kwargs):
        executed = self.schema.execute(*args, **dict(self.execute_options, **kwargs))
        if is_thenable(executed):
            return Promise.resolve(executed).then(self.format_result)

        return self.format_result(executed)
