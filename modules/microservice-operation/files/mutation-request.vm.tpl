#set ($params = {})
#foreach ($entry in $utils.defaultIfNull($context.source, {}).entrySet())
#if($context.arguments.get($entry.key))
$util.quiet($params.put("source_$${entry.key}", $entry.value))
#else
$util.quiet($params.put($entry.key, $entry.value))
#end
#end
#foreach ($entry in $context.arguments.entrySet())
$util.quiet($params.put($entry.key, $entry.value))
#end
%{ if "" != lookup(config, "idAsInput", "") ~}
$util.quiet($params.get("input").put("${config.idAsInput}", $params.get("id")))
%{ endif ~}
%{ if "" != lookup(config, "forcedInput", "") ~}
#set ($inputParams = $utils.defaultIfNull($params.get("input"), {}))
#foreach ($entry in $utils.defaultIfNull($util.parseJson("${config.forcedInput}"), {}).entrySet())
$util.quiet($inputParams.put($entry.key, $entry.value))
#end
$util.quiet($params.put("input", $inputParams))
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
