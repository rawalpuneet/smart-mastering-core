xquery version "1.0-ml";

(:~
 : Defines a match algorithm for matching between 9- and 5-digit US zip codes.
 :)
module namespace algorithms = "http://marklogic.com/smart-mastering/algorithms";

declare namespace matcher = "http://marklogic.com/smart-mastering/matcher";

declare option xdmp:mapping "false";

(:~
 : Allow matches between 5- and 9-digit US ZIP codes.
 : For more information, see https://marklogic-community.github.io/smart-mastering-core/docs/match-algorithms/#zip
 :
 : @param $expand-values  the value(s) that the original document has for this property
 : @param $expand-xml  the scoring/expand element in the match options that applies this algorithm to a property
 : @param $options-xml  the complete match options
 :
 : @return a sequence of cts:querys based on the property values in the original document
 :)
declare function algorithms:zip-match(
  $expand-values as xs:string*,
  $expand-xml as element(matcher:expand),
  $options-xml as element(matcher:options)
)
  as cts:query*
{
  let $property-name := $expand-xml/@property-name
  let $property-def := $options-xml/matcher:property-defs/matcher:property[@name = $property-name]
  let $qname := fn:QName($property-def/@namespace, $property-def/@localname)
  let $sep := "-"
  let $origin-5-weight := $expand-xml/matcher:zip[@origin = "5"]/@weight/fn:data()
  let $origin-9-weight := $expand-xml/matcher:zip[@origin = "9"]/@weight/fn:data()
  for $value in $expand-values
  return
    if (fn:string-length($value) = 5) then
      cts:element-value-query($qname, $value || $sep || "*", (), $origin-5-weight)
    else
      cts:element-value-query($qname, fn:substring($value, 1, 5), (), $origin-9-weight)
};
