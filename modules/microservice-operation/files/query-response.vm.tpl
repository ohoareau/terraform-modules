#if ( $ctx.error )
    $util.error($ctx.error.message, $ctx.error.errorType)
#end
#if ( $ctx.result and $ctx.result.errorType )
    $util.error($ctx.result.message, $ctx.result.errorType, $ctx.result.data, $ctx.result.errorInfo)
#end
$util.toJson($ctx.result)
