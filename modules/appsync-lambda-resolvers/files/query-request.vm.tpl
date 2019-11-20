#set ($params = {})
#foreach ($entry in $utils.defaultIfNull($context.source, {}).entrySet())
#if($context.arguments.get($entry.key))
$util.quiet($params.put("${sourcePrefix}$${entry.key}", $entry.value))
#else
$util.quiet($params.put($entry.key, $entry.value))
#end
#end
#foreach ($entry in $context.arguments.entrySet())
$util.quiet($params.put($entry.key, $entry.value))
#end
%{ if config && "" != lookup(config, "filter", "") ~}
$util.quiet($params.put("criteria", {"${config.filter}": $context.arguments.get("${config.filter}")}))
%{ endif ~}
{
    "version": "2018-05-29",
    "operation": "Invoke",
    "payload": {
        "params": $utils.toJson($params),
        "headers": $utils.toJson($context.request.headers),
        "user": $utils.toJson($context.identity)
    }
}
