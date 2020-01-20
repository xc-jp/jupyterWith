let
  inherit (builtins) attrNames filter removeAttrs;
in
{
  removeNulls = attrs:
    let nulls = filter (n: isNull attrs.${n}) (attrNames attrs);
    in removeAttrs attrs nulls;
}
